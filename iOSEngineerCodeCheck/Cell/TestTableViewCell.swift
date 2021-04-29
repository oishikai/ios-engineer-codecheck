//
//  TestTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/29.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var repositoryTitle: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    static let cellIdentifier = String(describing: TestTableViewCell.self)

}
