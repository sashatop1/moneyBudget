import UIKit
import RealmSwift

class UserExpenseType: Object {
    @objc dynamic var userExpenesType: String = ""
    
    convenience init(userExpenseType: String) {
        self.init()
        
        self.userExpenesType = userExpenseType
    }
}
