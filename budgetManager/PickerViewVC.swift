//
//  ViewController.swift
//  budgetManager
//
//  Created by Александ on 14.10.2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

class PickerViewVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    
    @IBAction func showResultsTapped(_ sender: UIButton) {
//        for i in 0..<BudgetManager.shared.savedObjects.count {
//            let a = BudgetManager.shared.savedObjects[i]
//            print("\(a.summaTrati) of \(a.name)")
//        }
//        BudgetManager.shared.savedObjects.forEach { (Trata) in
//            print("\(Trata.summaTrati) of \(Trata.name)")
//        }
        BudgetManager.shared.savedObjects.forEach({ print("\($0.summaTrati) of \($0.name)") })

//        BudgetManager.shared.savedObjects.enumerated().forEach { (i, a) in
//            print("\(a.summaTrati) of \(a.name)")
//        }
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var moneyTypePicker: UIPickerView!
    @IBAction func AddChoice(_ sender: Any) {
        if let text = textField.text, let doubleValue = Double(text) {
            let moneySelectedRow = moneyTypePicker.selectedRow(inComponent: 0)
            let userPick = Trata(amountOfUserPick: doubleValue, userPick: MoneyType.allCasesDescription()[moneySelectedRow])
            BudgetManager.shared.savedObjects.append(userPick)
        }
    }
    
    var amountOfUserPick: Double = 0
    var userChoice: String = ""
    let array = ["Earned", "Car", "House", "Fun", "Saving"]
    enum MoneyType: CaseIterable {
        case Earned
        case Car
        case House
        case Fun
        case Saving
        static func allCasesDescription() -> [String] {
            let allCasesString = MoneyType.allCases.map { (type) -> String in
                return type.description
            }
            return allCasesString
        }
        var description: String {
            switch self {
            case .Earned: return "Earned"
            case .Car: return "Car"
            case .House: return "House"
            case .Fun: return "Fun"
            case .Saving: return "Saving"
            
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyTypePicker.dataSource = self
        moneyTypePicker.delegate = self
    }
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            _ = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
}






