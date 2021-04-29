//
//  TestTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/29.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import Nuke

class RepositoriesTableViewCell: UITableViewCell {

    @IBOutlet private weak var repositoryImageView: UIImageView!
    @IBOutlet private weak var repositoryTitle: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!

    static let cellIdentifier = String(describing: RepositoriesTableViewCell.self)

    func setup(repository: Repository) {
        repositoryTitle.text = repository.fullName

        if let url = repository.avatarImageUrl {
            Nuke.loadImage(with: url, into: repositoryImageView)
        } else {
            repositoryImageView.image = nil
        }

        languageLabel.text = repository.language ?? ""
    }
}
