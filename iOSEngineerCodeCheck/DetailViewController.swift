//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watcherLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    var repository: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = repository?.fullName
        languageLabel.text = "Written in \(repository?.language ?? "")"
        starsLabel.text = "\(repository?.stargazersCount ?? 0) stars"
        watcherLabel.text = "\(repository?.watchersCount ?? 0) watchers"
        forksLabel.text = "\(repository?.forksCount ?? 0) forks"
        issuesLabel.text = "\(repository?.openIssuesCount ?? 0) open issues"

        if let avatarImageUrl = repository?.avatarImageUrl {
            Nuke.loadImage(with: avatarImageUrl, into: imageView)
        }
    }
}
