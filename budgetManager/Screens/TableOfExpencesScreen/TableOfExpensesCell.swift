//
//  TableViewCell.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

class TableOfExpensesCell: UITableViewCell {
    static let identifier = "MainVCCell"
    
    //лучше удалить аутлет, который не ссылается ни на что в сториборде
    //@IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupCell(withEntity entity: Trata) {
        nameLabel.text = entity.name
        descriptionLabel.text = String(entity.summaTrati)
        
        //в сетапе не было передано значение для аутлета colorView с типом UIView! (который 100% ожидает значение), в результате чего был бы краш
    }
    
}


