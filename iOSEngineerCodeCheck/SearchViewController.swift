//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

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
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
