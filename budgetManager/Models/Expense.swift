//
//  UserPickVCViewController.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit
import RealmSwift

class Expense: Object {
    @objc dynamic var amountExpense: Double = 0
    @objc dynamic var expenseType: String = ""
    //@objc dynamic var userExpenseType: String = "" 
    
    convenience init(amountOfUserPick: Double, userPick: String) {
        self.init()
        
        //self.userExpenseType = userExpenseType
        self.amountExpense = amountOfUserPick
        self.expenseType = userPick
    }
}
