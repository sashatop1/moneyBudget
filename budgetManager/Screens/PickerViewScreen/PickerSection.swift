//
//  PickerSection.swift
//  budgetManager
//
//  Created by Александ on 01/04/2019.
//  Copyright © 2019 Александ. All rights reserved.
//

import Foundation

class PickerSection {
    var name: String
    var array: [UserExpenseType]
    
    init(name: String, array: [UserExpenseType]) {
        
        self.name = name
        self.array = array
    }
    
}
