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
    var onTap: (() -> Void)?
    
    private lazy var tap: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap))
    }()
   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
