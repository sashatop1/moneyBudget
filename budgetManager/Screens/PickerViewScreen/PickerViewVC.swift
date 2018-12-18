//
//  ViewController.swift
//  budgetManager
//
//  Created by Александ on 14.10.2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

//вынес жирный энум в шапку файла, потому что с ним скорее всего будут работать несколько классов и обращаться через PickerViewVC.MoneyType каждый раз будет неудобно
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
    
    static func allCasesDescription() -> [String] {
        //короче и проще
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
    
    
    // MARK: - Properties
    var selectedAmount: Double = 0
    var userChoice: String = MoneyType.allCasesDescription().first!
    var titlesForPicker = MoneyType.allCasesDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        textFieldAmount.delegate = self
        if textFieldAmount.text!.isEmpty == true {
            addChoiceButton.isUserInteractionEnabled = false
            addChoiceButton.alpha = 0.7
        }
        
    }
    
    private func configureView() {
        moneyTypePicker.dataSource = self
        moneyTypePicker.delegate = self
        
        self.view.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        self.textFieldAmount.backgroundColor = UIColor.init(red: 0.38, green: 0.45, blue: 0.48, alpha: 1)
        self.textFieldExpenseType.backgroundColor = UIColor.init(red: 0.38, green: 0.45, blue: 0.48, alpha: 1)
        self.textFieldAmount.textColor = UIColor.white
        self.textFieldExpenseType.textColor = UIColor.white
        self.textFieldAmount.attributedPlaceholder = NSAttributedString(string: "Enter amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4)])
        self.textFieldExpenseType.attributedPlaceholder = NSAttributedString(string: "Enter new type", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4)])
        self.createTypeButton.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.06, green: 0.13, blue: 0.15, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)]
        if BudgetManager.DBHasEntries(ofType: UserExpenseType.self) == true { 
        }
    }
    
   
}

// MARK: - @IBActions
extension PickerViewVC {
    @IBAction func AddingNewType(_ sender: Any) {
        guard let expenseTypeName = textFieldExpenseType.text else { return }
        
        let newExpenseType = UserExpenseType(userExpenseType: expenseTypeName)
        BudgetManager.addExpenseType(object: newExpenseType)
    }
    
    @IBAction func AddChoice(_ sender: Any) {
        guard let text = textFieldAmount.text, let doubleValue = Double(text) else { return }
        
        let userExpense = Expense(amountOfUserPick: doubleValue, userPick: userChoice)
        BudgetManager.addObject(object: userExpense)
        
        textFieldAmount.text = ""
    }
}

extension PickerViewVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: MoneyType.allCasesDescription()[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MoneyType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userChoice = MoneyType.allCasesDescription()[row]
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textFieldAmount.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty {
            addChoiceButton.isUserInteractionEnabled = true
            addChoiceButton.alpha = 1
        } else {
            addChoiceButton.isUserInteractionEnabled = false
            addChoiceButton.alpha = 0.7
            
        }
        return true
        
    }
}







