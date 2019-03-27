//
//  TableOfExpensesSection.swift
//  budgetManager
//
//  Created by Александ on 24/03/2019.
//  Copyright © 2019 Александ. All rights reserved.
//

import UIKit

class TableOfExpensesSection {
    var isExpanded: Bool = true
    var name: String
    var array: [Expense]
    
    init(name: String, array: [Expense]) {
        
        self.name = name
        self.array = array
    }
    
}
