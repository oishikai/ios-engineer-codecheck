//
//  RepositoriesTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Kai on 2021/04/29.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var repositoryTitle: UILabel!
    
    static let cellIdentifier = String(describing: RepositoriesTableViewCell.self)

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
