//
//  ColorLanguageViewController.swift
//  budgetManager
//
//  Created by Александ on 03/04/2019.
//  Copyright © 2019 Александ. All rights reserved.
//

import UIKit

class ColorLanguageViewController: UIViewController {
    
    @IBOutlet weak var colorThemeLabels: UILabel!
    
    @IBOutlet weak var darkThemeOutlet: UISwitch!
    
    @IBOutlet weak var lightThemeOutlet: UISwitch!
    
    @IBOutlet weak var funThemeOutlet: UISwitch!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var darkLabel: UILabel!
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var funLabel: UILabel!
    
    let tableVC = TableOfExpensesViewController()
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        
        
        
        darkThemeOutlet.isOn = true
        lightThemeOutlet.isOn = false
        funThemeOutlet.isOn = false
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func darkThemeSwitcher(_ sender: Any) {
        if darkThemeOutlet.isOn == false {
            self.alert(title: "Error", message: "Dark theme is already on!", style: .alert)
            darkThemeOutlet.isOn = true
            return
        }
        else { lightThemeOutlet.isOn = false
            funThemeOutlet.isOn = false
            Theme.current = DarkTheme()
        
            applyTheme()
    
            
        }
    
        
    }
    @IBAction func lightThemeSwitcher(_ sender: Any) {
        if lightThemeOutlet.isOn == false {
            self.alert(title: "Error", message: "Light theme is already on!", style: .alert)
            lightThemeOutlet.isOn = true
            return
        }
        else { darkThemeOutlet.isOn = false
            funThemeOutlet.isOn = false
            Theme.current = LightTheme()
            applyTheme()
        }
    }
    @IBAction func funThemeSwitcher(_ sender: Any) {
        if funThemeOutlet.isOn == false {
            self.alert(title: "Error", message: "Dark theme is already on!", style: .alert)
            funThemeOutlet.isOn = true
            return
        }
        else { lightThemeOutlet.isOn = false
            darkThemeOutlet.isOn = false
            Theme.current = FunTheme()
            applyTheme()
        }
    }
    
    func applyTheme() {
        self.view.backgroundColor = Theme.current.backgroundColor
        mainLabel.textColor = Theme.current.labelColor
        darkLabel.textColor = Theme.current.labelColor
        lightLabel.textColor = Theme.current.labelColor
        funLabel.textColor = Theme.current.labelColor
        navigationController?.navigationBar.barTintColor = Theme.current.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.current.labelColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.labelColor]
        tableVC.self.view.backgroundColor = Theme.current.backgroundColor
    }
    
}
