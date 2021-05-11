//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import JGProgressHUD

class SearchViewController: UITableViewController {
    
    @IBOutlet private weak var searchBer: UISearchBar!
    
    private var repositories: [Repository] = []
    
    private var task: URLSessionTask?
    
    private var word: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBer.delegate = self
        
        let nib = UINib(nibName: RepositoriesTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RepositoriesTableViewCell.cellIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoriesTableViewCell.cellIdentifier, for: indexPath) as! RepositoriesTableViewCell

        let repository = repositories[indexPath.row]
        cell.setup(repository: repository)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: String(describing: DetailViewController.self), bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController { coder in
            DetailViewController(coder: coder, repository: self.repositories[indexPath.row])
        }
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
}

extension  SearchViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard searchBar.text != nil else {return}
        word = searchBar.text!
        
        let progressHUD = JGProgressHUD()
        progressHUD.show(in: self.view)
        
        GitHubRepository.searchRepository(text: word) { result in
            DispatchQueue.main.async {
                progressHUD.dismiss()
            }
            
            switch result {
            case .success(let items):
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

}
