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
    
    var repositories: [[String: Any]] = []
    
    var task: URLSessionTask?
    var word: String!
    var idx: Int!
    
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
        word = searchBar.text!
        
        if word.count != 0 {
            let urlString = "https://api.github.com/search/repositories?q=\(word!)"
            guard let url = URL(string: urlString) else {return}
            
            task = URLSession.shared.dataTask(with: url) { (data, res, err) in
                guard let Data = data else {return}
                if let obj = try? JSONSerialization.jsonObject(with: Data) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        self.repositories = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task?.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let dtl = segue.destination as! DetailViewController
            dtl.vc1 = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repositories[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
