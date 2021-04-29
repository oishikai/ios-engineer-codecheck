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
    
    private var repositories: [[String: Any]] = []
    
    private var task: URLSessionTask?
    
    private var word: String!
    private var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBer.text = "GitHubのリポジトリを検索できるよー"
        searchBer.delegate = self
        
//        let nib = UINib(nibName: RepositoriesTableViewCell.cellIdentifier, bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: RepositoriesTableViewCell.cellIdentifier)
        
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
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            
            if let detailViewController = segue.destination as? DetailViewController {
                detailViewController.repository = self.repositories[selectedIndex]
            } else {
                print("画面遷移エラー")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoriesTableViewCell.cellIdentifier, for: indexPath) as! RepositoriesTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoriesTableViewCell.cellIdentifier, for: indexPath) as! RepositoriesTableViewCell

        let repository = repositories[indexPath.row]
        cell.repositoryTitle.text = repository["full_name"] as? String ?? ""

        let url = GitHubRepository.getImage(repository: repository)
        Nuke.loadImage(with: url, into: cell.repositoryImageView)
//        cell.languageLabel.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
