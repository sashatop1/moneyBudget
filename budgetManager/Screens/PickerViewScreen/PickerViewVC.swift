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

class PickerViewVC: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var moneyTypePicker: UIPickerView!
    @IBOutlet weak var textFieldExpenseType: UITextField!
    
    
    // MARK: - Properties
    var selectedAmount: Double = 0
    var userChoice: String = MoneyType.allCasesDescription().first!
    var titlesForPicker = MoneyType.allCasesDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        moneyTypePicker.dataSource = self
        moneyTypePicker.delegate = self
        
        if BudgetManager.DBHasEntries(ofType: UserExpenseType.self) == true {
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
    }
}

extension PickerViewVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MoneyType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return MoneyType.allCasesDescription()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userChoice = MoneyType.allCasesDescription()[row]
    }
}







