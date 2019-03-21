//
//  TableOfExpensesHeader.swift
//  budgetManager
//
//  Created by Александ on 04/03/2019.
//  Copyright © 2019 Александ. All rights reserved.
//

import UIKit

class TableOfExpensesHeader: UITableViewHeaderFooterView {
    
    static let headerIdentifier = "headerId"
    var headerCellSection: Int?
    let header = UITableViewHeaderFooterView()
    
   
    func setupHeader() {
        
        let tap = UIGestureRecognizer(target: self, action:#selector(handleTap(_:)))
        self.addGestureRecognizer(tap)
        header.backgroundColor = UIColor.white
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
    
    }
    
}
