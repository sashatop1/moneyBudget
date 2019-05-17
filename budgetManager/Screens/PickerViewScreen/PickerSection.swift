import Foundation

class PickerSection {
    var name: String
    var array: [UserExpenseType]
    
    init(name: String, array: [UserExpenseType]) {
        
        self.name = name
        self.array = array
    }
    
}
