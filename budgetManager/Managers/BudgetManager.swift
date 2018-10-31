//
//  budgetManager.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import Foundation

class BudgetManager {
    //наш синглтон
    static let shared = BudgetManager()
    
    /*свойство объявлено как приватное, потому что этот массив играет роль нашей БД
     БД обычно имеют обертку для доступа/записи информации
     В этом маленьком проекте это мб лишняя запара, но зато поймешь, зачем нужны private свойства, что такое custom accessors,
     как работает синглтон и обертки над ним
    */
    private var savedObjects = [Expense]()
    
    //все эти методы - это обертки над синглтоном, вызываем как статик прямо из класса, но в итоге работаем именно с синглтоном
    static func allObjects() -> [Expense] {
        return shared.savedObjects
    }
    
    static func addObject(object: Expense) {
        shared.savedObjects.append(object)
    }
    
    static func addObjects(objects: [Expense]) {
        shared.savedObjects.append(contentsOf: objects)
    }
}
