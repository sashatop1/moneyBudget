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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupCell(withModel model: Expense) {
        nameLabel.text = model.expenseType
        descriptionLabel.text = String(model.amountExpense)
        
    }

    
}


