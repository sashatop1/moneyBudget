//
//  TableViewCell.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "MainVCCell"
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
 

    override func prepareForReuse() {
    }
    func setupCell(withEntity entity: Trata) {
        nameLabel.text = entity.name
        descriptionLabel.text = String(entity.summaTrati)
    }

        // Configure the view for the selected state
    }


