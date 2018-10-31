//
//  budgetManager.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import Foundation
import RealmSwift

class BudgetManager {
    //наш синглтон
    private static let shared = BudgetManager()
    private let realmInstance = try! Realm()
    private static let realm = shared.realmInstance
    
    static func allObjects() -> [Expense] {
        return Array(realm.objects(Expense.self))
    }
    
    static func addObject(object: Expense) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func getTotalExpenses(forExpenseType type: String) -> Int {
       return Int(allObjects().filter { $0.expenseType == type }.reduce(0) { $0 + $1.amountExpense })
    }
}
