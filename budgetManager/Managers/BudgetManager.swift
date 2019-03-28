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
    
    //Приватный коструктор не позволит другим классам создать инстанс BudgetManager
    //Таким образом наш синглтон "shared" точно будет единственным инстансом класса в проекте
    private init(){}
    
    static func allObjects() -> [Expense] {
        return Array(realm.objects(Expense.self))
    }
    
    static func addObject(object: Expense) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    static func addExpenseType(object: UserExpenseType) {
        try! realm.write {
            realm.add(object)
        }
        
    }
    
    static func deleteExpenseType(object: UserExpenseType) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    static func DBHasEntries(ofType type: UserExpenseType.Type) -> Bool {
        return !realm.objects(type).isEmpty

    }
    
    
    static func deleteObject(object: Expense) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    static func allExpenseTypes() -> [UserExpenseType] {
        return Array(realm.objects(UserExpenseType.self))
    }
    
    static func getTotalExpenses(forExpenseType type: String) -> Int {
       return Int(allObjects().filter { $0.expenseType == type }.reduce(0) { $0 + $1.amountExpense })
    }
}
