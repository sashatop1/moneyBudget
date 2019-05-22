import UIKit

enum MoneyType: CaseIterable {
    case Earned
    case Car
    case House
    case Fun
    case Saving
    
    var description: String {
        switch self {
        case .Earned: return "Earned"
        case .Car: return "Car"
        case .House: return "House"
        case .Fun: return "Fun"
        case .Saving: return "Saving"
            
        }
    }
    
    static func allCasesDescriptionDefault() -> [String] {
        return MoneyType.allCases.map { $0.description }
    }
    
}

class PickerViewVC: BaseController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var moneyTypePicker: UIPickerView!
    @IBOutlet weak var textFieldExpenseType: UITextField!
    @IBOutlet weak var addChoiceButton: UIButton!
    @IBOutlet weak var createTypeButton: UIButton!
    @IBOutlet weak var deleteTypeButton: UIButton!
    @IBOutlet weak var tableButton: UIButton!
    
    
    
    // MARK: - Properties
    var selectedAmount: Double = 0
    var pickerviewValues: [String] { return MoneyType.allCasesDescriptionDefault() + BudgetManager.allExpenseTypes().map { $0.userExpenesType} }
    var userChoice: String = MoneyType.allCasesDescriptionDefault().first!
    var indexOfPicker = Int()
    
    var sections: [PickerSection] = {
        let sections = BudgetManager.allExpenseTypes()
        let names = sections.map { $0.userExpenesType }
        return names.map { group -> PickerSection in
            let correspondingSections = sections.filter { $0.userExpenesType == group }
            return PickerSection(name: group, array: correspondingSections)
        }
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        
        self.addTapGestureToHideKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        applyTheme()
    }
    func getAllStrings() -> [String] {
        let array = BudgetManager.allExpenseTypes()
        let allStrings1 = array.map { $0.userExpenesType }
        let allStrings = MoneyType.allCasesDescriptionDefault() + allStrings1
        return allStrings
    }
    
    
    @objc func applyTheme() {
        self.view.backgroundColor = ThemeManager.shared.current.backgroundColor
//        moneyTypePicker.layer.borderWidth = 1
//        moneyTypePicker.layer.borderColor = ThemeManager.shared.current.labelColor.cgColor
//        moneyTypePicker.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        self.tableButton.setTitleColor(ThemeManager.shared.current.labelColor, for: .normal)
        self.addChoiceButton.setTitleColor(ThemeManager.shared.current.labelColor, for: .normal)
        self.createTypeButton.setTitleColor(ThemeManager.shared.current.labelColor, for: .normal)
        self.deleteTypeButton.setTitleColor(ThemeManager.shared.current.labelColor, for: .normal)
        tableButton.titleLabel?.textColor = ThemeManager.shared.current.labelColor
        addChoiceButton.titleLabel?.textColor = ThemeManager.shared.current.labelColor
        deleteTypeButton.titleLabel?.textColor = ThemeManager.shared.current.labelColor
        createTypeButton.titleLabel?.textColor = ThemeManager.shared.current.labelColor
        textFieldExpenseType.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        textFieldExpenseType.attributedPlaceholder = NSAttributedString(string: "Enter expense type", attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.textFieldsPlaceholder])
        textFieldExpenseType.textColor = ThemeManager.shared.current.labelColor
        textFieldAmount.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        textFieldAmount.attributedPlaceholder = NSAttributedString(string: "Enter amount", attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.textFieldsPlaceholder])
        textFieldAmount.textColor = ThemeManager.shared.current.labelColor
        navigationController?.navigationBar.barTintColor = ThemeManager.shared.current.navigationBackground
        navigationController?.navigationBar.tintColor = ThemeManager.shared.current.labelColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.labelColor]
        navigationItem.rightBarButtonItem?.tintColor = ThemeManager.shared.current.labelColor
        self.tabBarController?.tabBar.tintColor = ThemeManager.shared.current.itemTintColor
        self.tabBarController?.tabBar.barTintColor = ThemeManager.shared.current.navigationBackground
        self.tabBarController?.tabBar.unselectedItemTintColor = ThemeManager.shared.current.unselectedItemTintColor
        moneyTypePicker.reloadAllComponents()
        tableButton.layer.borderColor = ThemeManager.shared.current.labelColor.cgColor
        addChoiceButton.layer.borderColor = ThemeManager.shared.current.labelColor.cgColor
        deleteTypeButton.layer.borderColor = ThemeManager.shared.current.labelColor.cgColor
        createTypeButton.layer.borderColor = ThemeManager.shared.current.labelColor.cgColor
        tableButton.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        addChoiceButton.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        deleteTypeButton.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        createTypeButton.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        
    }
    private func configureView() {
        moneyTypePicker.dataSource = self
        moneyTypePicker.delegate = self
        textFieldAmount.delegate = self
        
        applyTheme()
        
        if textFieldAmount.text!.isEmpty {
            addChoiceButton.isUserInteractionEnabled = false
            addChoiceButton.alpha = 0.5
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(navigateToColors))
        tableButton.layer.borderWidth = 1
        tableButton.layer.cornerRadius = 15
        addChoiceButton.layer.borderWidth = 1
        addChoiceButton.layer.cornerRadius = 15
        deleteTypeButton.layer.borderWidth = 1
        deleteTypeButton.layer.cornerRadius = 15
        createTypeButton.layer.borderWidth = 1
        createTypeButton.layer.cornerRadius = 15
        
    }
    
    @objc func navigateToColors() {
        self.performSegue(withIdentifier: "goToColors", sender: self)
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

// MARK: - @IBActions
extension PickerViewVC {
    @IBAction func AddingNewType(_ sender: Any) {
        let letters = NSCharacterSet.letters
        guard let expenseTypeName = textFieldExpenseType.text, textFieldExpenseType.text?.rangeOfCharacter(from: letters) != nil else {
            self.alert(title: "Error", message: "New expense type is invalid. Please fill the field correctly.", style: .alert)
            return }
        let newExpenseType = UserExpenseType(userExpenseType: expenseTypeName)
        BudgetManager.addExpenseType(object: newExpenseType)
        moneyTypePicker.reloadAllComponents()
        textFieldExpenseType.text?.removeAll()
    }
    
    
    @IBAction func deleteTypeAction(_ sender: Any) {
        if moneyTypePicker.selectedRow(inComponent: 0) > 4 {
            let valueStr = pickerviewValues[moneyTypePicker.selectedRow(inComponent: 0)]
            let object = BudgetManager.allExpenseTypes().first { $0.userExpenesType == valueStr }
            BudgetManager.deleteExpenseType(object: object!)
            moneyTypePicker.reloadAllComponents() }
        else {
            self.alert(title: "Error", message: "You cannot delete default types of expense", style: .alert)
            return
        }
    }
    
    
    
    @IBAction func AddChoice(_ sender: Any) {
        guard let text = textFieldAmount.text, let doubleValue = Double(text) else { return }
        let valueStr = pickerviewValues[moneyTypePicker.selectedRow(inComponent: 0)]
        let userExpense = Expense(amountOfUserPick: doubleValue, userPick: valueStr)
        BudgetManager.addObject(object: userExpense)
        textFieldAmount.text?.removeAll()
        view.endEditing(true)
    }
    
}

extension PickerViewVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        indexOfPicker = row
        
        if UserDefaults.standard.bool(forKey: "black") {
            let myTitle = NSAttributedString(string: pickerviewValues[indexOfPicker], attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.labelColor])
            
            return myTitle
        } else if UserDefaults.standard.bool(forKey: "white") {
            let myTitle = NSAttributedString(string: pickerviewValues[indexOfPicker], attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.labelColor])
            
            return myTitle
        } else if UserDefaults.standard.bool(forKey: "fun") {
            let myTitle = NSAttributedString(string: pickerviewValues[indexOfPicker], attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.labelColor])
            return myTitle
        } else {
            let myTitle = NSAttributedString(string: pickerviewValues[indexOfPicker], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            return myTitle
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerviewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexOfPicker = row
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")

        let textExpense = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if !textExpense.isEmpty {
            addChoiceButton.isUserInteractionEnabled = true
            addChoiceButton.alpha = 1
        } else {
            addChoiceButton.isUserInteractionEnabled = false
            addChoiceButton.alpha = 0.5

        }
        return string == numberFiltered
        

    }
    
    
    
}







