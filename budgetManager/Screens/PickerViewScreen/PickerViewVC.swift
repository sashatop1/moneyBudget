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
        //короче и прощe
        //return BudgetManager.allExpenseTypes().map { $0.userExpenesType }
        return MoneyType.allCases.map { $0.description }
    }
    static func allCasesDesctiptionDefault() -> [String] {
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
    @IBOutlet weak var goToColorThemesButton: UIBarButtonItem!
    
   
    
    // MARK: - Properties
    var selectedAmount: Double = 0
    var pickerviewValues: [String] = MoneyType.allCasesDescription() + BudgetManager.allExpenseTypes().map { $0.userExpenesType}
    var userChoice: String = MoneyType.allCasesDesctiptionDefault().first!
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
        
        //связку делегатов можно вынести в отдельный метод, ты ведь для пикера делегаты связываешь в configureView()
        textFieldAmount.delegate = self
        //1) незачем делать эту проверку, экран с пустым текстфилдом появляется, значит всегда будет trueи всегда выполнится блок
        //2) "text!" не стал бы делать
        //3) == true можно убрать, сравнение излишне потому что isEmpty уже Bool
        if textFieldAmount.text!.isEmpty == true {
            addChoiceButton.isUserInteractionEnabled = false
            addChoiceButton.alpha = 0.7
        }
        
    }
    func getAllStrings() -> [String] {
        var array = BudgetManager.allExpenseTypes()
        var allStrings1 = array.map { $0.userExpenesType }
        var allStrings = MoneyType.allCasesDesctiptionDefault() + allStrings1
        return allStrings
    }
    
    private func configureView() {
        moneyTypePicker.dataSource = self
        moneyTypePicker.delegate = self
        
        /* хорошо, что попробовал кодом настраивать экран, но обычно для разгрузки класса как можно больше
         настройки делается в сториборде.
         + совет: вынеси основные цвета в отдельный файл с константами чтобы каждый раз не указывать значения RGBA,
         так можно легко где-нибудь лажануть
         */
        //.init обычно е используется, лучше юзать конструктор UIColor(red:green:blue:alpha)
        self.view.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        self.textFieldAmount.backgroundColor = UIColor.init(red: 0.38, green: 0.45, blue: 0.48, alpha: 1)
        self.textFieldExpenseType.backgroundColor = UIColor.init(red: 0.38, green: 0.45, blue: 0.48, alpha: 1)
        self.textFieldAmount.textColor = UIColor.white // можно заменить на просто .white
        self.textFieldExpenseType.textColor = UIColor.white
        // тут можно использовать UIColor(white: alpha:)
        self.textFieldAmount.attributedPlaceholder = NSAttributedString(string: "Enter amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4)])
        self.textFieldExpenseType.attributedPlaceholder = NSAttributedString(string: "Enter new type", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.4)])
        self.createTypeButton.backgroundColor = UIColor.clear //.clear
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.06, green: 0.13, blue: 0.15, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.white] // .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(navigateToColors))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
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
        pickerviewValues.append(expenseTypeName)
        moneyTypePicker.reloadAllComponents()
        textFieldExpenseType.text?.removeAll()
    }
    
    
    @IBAction func deleteTypeAction(_ sender: Any) {
        if indexOfPicker > 4 {
            let array = BudgetManager.allExpenseTypes().map { $0.userExpenesType }
//            let array2 = array.map { $0.userExpenesType }
            let valueStr = pickerviewValues[indexOfPicker]
//            let indexof = array2.firstIndex(of: valueStr)
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
        let userExpense = Expense(amountOfUserPick: doubleValue, userPick: userChoice)
        BudgetManager.addObject(object: userExpense)
        textFieldAmount.text?.removeAll()
    }
    
}

extension PickerViewVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        indexOfPicker = row
        return NSAttributedString(string: getAllStrings()[indexOfPicker], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getAllStrings().count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexOfPicker = row
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textFieldAmount.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty {
            addChoiceButton.isUserInteractionEnabled = true
            addChoiceButton.alpha = 1
        } else {
            addChoiceButton.isUserInteractionEnabled = false
            addChoiceButton.alpha = 0
            
        }
        return true
        }
}







