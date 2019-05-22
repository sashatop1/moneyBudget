import UIKit

class TableOfExpensesCell: UITableViewCell {
    static let identifier = "MainVCCell"
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupCell(withModel model: Expense) {
        
        
        
        nameLabel.text = model.expenseType
        descriptionLabel.text = String(model.amountExpense)
        
        
        self.nameLabel.textColor = ThemeManager.shared.current.labelColor
        self.descriptionLabel.textColor = ThemeManager.shared.current.labelColor
        self.backgroundColor = ThemeManager.shared.current.backgroundColor
        self.selectedBackgroundView?.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        
    }
    
    
}


