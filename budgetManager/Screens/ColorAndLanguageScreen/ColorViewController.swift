import UIKit

class ColorViewController: UIViewController {
    
    
    @IBOutlet weak var colorThemeLabels: UILabel!
    @IBOutlet weak var darkThemeOutlet: UISwitch!
    @IBOutlet weak var lightThemeOutlet: UISwitch!
    @IBOutlet weak var funThemeOutlet: UISwitch!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var darkLabel: UILabel!
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var funLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        if UserDefaults.standard.bool(forKey: "black") {
            darkThemeOutlet.isOn = true
            lightThemeOutlet.isOn = false
            funThemeOutlet.isOn = false
        } else if UserDefaults.standard.bool(forKey: "white") {
            darkThemeOutlet.isOn = false
            lightThemeOutlet.isOn = true
            funThemeOutlet.isOn = false
        } else if UserDefaults.standard.bool(forKey: "fun") {
            darkThemeOutlet.isOn = false
            lightThemeOutlet.isOn = false
            funThemeOutlet.isOn = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applyTheme()
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in }
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
            ThemeManager.shared.current = DarkTheme()
            UserDefaults.standard.set(true, forKey: "black")
            UserDefaults.standard.set(false, forKey: "white")
            UserDefaults.standard.set(false, forKey: "fun")
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
            ThemeManager.shared.current = LightTheme()
            UserDefaults.standard.set(true, forKey: "white")
            UserDefaults.standard.set(false, forKey: "black")
            UserDefaults.standard.set(false, forKey: "fun")
            
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
            ThemeManager.shared.current = FunTheme()
            UserDefaults.standard.set(true, forKey: "fun")
            UserDefaults.standard.set(false, forKey: "black")
            UserDefaults.standard.set(false, forKey: "white")
            applyTheme()
        }
    }
    
    @objc func applyTheme() {
        view.backgroundColor = ThemeManager.shared.current.backgroundColor
        mainLabel.textColor = ThemeManager.shared.current.labelColor
        darkLabel.textColor = ThemeManager.shared.current.labelColor
        lightLabel.textColor = ThemeManager.shared.current.labelColor
        funLabel.textColor = ThemeManager.shared.current.labelColor
        navigationController?.navigationBar.barTintColor = ThemeManager.shared.current.navigationBackground
        navigationController?.navigationBar.tintColor = ThemeManager.shared.current.labelColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.labelColor]
        navigationItem.rightBarButtonItem?.tintColor = ThemeManager.shared.current.labelColor
        self.tabBarController?.tabBar.tintColor = ThemeManager.shared.current.itemTintColor
        self.tabBarController?.tabBar.barTintColor = ThemeManager.shared.current.navigationBackground
        self.tabBarController?.tabBar.unselectedItemTintColor = ThemeManager.shared.current.unselectedItemTintColor
    }
    
}
