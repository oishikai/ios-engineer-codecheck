//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Nuke

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBer: UISearchBar!
    
    private var repositories: [Item] = []
    
    private var task: URLSessionTask?
    
    private var word: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBer.text = "GitHubのリポジトリを検索できるよー"
        searchBer.delegate = self
        
        let nib = UINib(nibName: RepositoriesTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RepositoriesTableViewCell.cellIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else {return}
        word = searchBar.text!
        
        GitHubRepository.searchRepository(text: word) { result in
            switch result {
            case .success(let items):
                print(items.count)
                self.repositories = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    switch error {
                    case .wrong :
                        let alert = ErrorAlert.wrongWordError()
                        self.present(alert, animated: true, completion: nil)
                        return
                    case .network:
                        let alert = ErrorAlert.networkError()
                        self.present(alert, animated: true, completion: nil)
                        return
                    case .parse:
                        let alert = ErrorAlert.parseError()
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
            }
        }
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoriesTableViewCell.cellIdentifier, for: indexPath) as! RepositoriesTableViewCell

        let repository = repositories[indexPath.row]
        cell.repositoryTitle.text = repository.fullName

        if let url = repository.avatarImageUrl {
            Nuke.loadImage(with: url, into: cell.repositoryImageView)
        } else {
            cell.repositoryImageView.image = nil
        }

        cell.languageLabel.text = repository.language ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "DetailViewController")as! DetailViewController
        nextVC.repository = repositories[indexPath.row]

        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
