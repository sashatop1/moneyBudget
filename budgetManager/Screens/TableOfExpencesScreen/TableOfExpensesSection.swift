import UIKit

class TableOfExpensesSection {
    var isExpanded: Bool
    var name: String
    var array: [Expense]
    
    
    init(name: String, array: [Expense]) {
        self.name = name
        self.array = array
        self.isExpanded = self.array.count < 4
        
    }
    
}
