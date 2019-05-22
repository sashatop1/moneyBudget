import UIKit
import RealmSwift

class Expense: Object {
    @objc dynamic var amountExpense: Double = 0
    @objc dynamic var expenseType: String = ""
    
    convenience init(amountOfUserPick: Double, userPick: String) {
        self.init()
        
        self.amountExpense = amountOfUserPick
        self.expenseType = userPick
    }
}
