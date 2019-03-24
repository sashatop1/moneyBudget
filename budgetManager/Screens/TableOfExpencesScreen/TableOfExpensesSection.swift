//
//  TableOfExpensesSection.swift
//  budgetManager
//
//  Created by Александ on 24/03/2019.
//  Copyright © 2019 Александ. All rights reserved.
//

import UIKit

class TableOfExpensesSection {
    var isExpanded: Bool = true //раскрыта секция или нет
    var name: String
    var array: [String]         //модели, которые в ячейки передаются
    
    init(name: String, array: [String]) {
        self.name = name
        self.array = array
    }
    
}
