//
//  UserExpenseType.swift
//  budgetManager
//
//  Created by Александ on 19/11/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import Foundation
import RealmSwift

class UserExpenseType: Object {
    @objc dynamic var userExpenesType: String = ""
    
    convenience init(userExpenseType: String) {
        self.init()
        
        self.userExpenesType = userExpenseType
    }
}
