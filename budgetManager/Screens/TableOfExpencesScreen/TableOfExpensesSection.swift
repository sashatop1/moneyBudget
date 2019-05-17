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
