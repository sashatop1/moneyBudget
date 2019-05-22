import UIKit
import Alamofire

class ExchangeRatesViewController: BaseController {
    
    //@IBOutlet weak var mainLabelOutlet: UILabel!
    
    @IBOutlet weak var rubTextField: UITextField!
    @IBOutlet weak var eurTextField: UITextField!
    @IBOutlet weak var czechTextField: UITextField!
    @IBOutlet weak var yuanTextField: UITextField!
    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var poundTextField: UITextField!
    @IBOutlet weak var rusLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var yuanLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var czkLabel: UILabel!
    
    @IBOutlet weak var currencyLabels: UIStackView!
    @IBOutlet weak var currencyTextFields: UIStackView!
    
    
    private var ratesData = ExchangeRatesModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTapGestureToHideKeyboard()
        getData()
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
        configureData()
    }
    
    private func getData() {
        let urlString = "https://api.ratesapi.io/api/latest?symbols=USD,GBP,RUB,CZK,CNY"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let rates = try JSONDecoder().decode(ExchangeRatesModel.self, from: data)
                DispatchQueue.main.async {
                    self.ratesData = rates
                    self.configureData()
                    
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            }.resume()
        
    }
    
    @objc func navigateToColors() {
        self.performSegue(withIdentifier: "goToColors", sender: self)
    }
    
    private func configureView() {
        self.view.backgroundColor = ThemeManager.shared.current.backgroundColor
        rusLabel.textColor = ThemeManager.shared.current.labelColor
        eurLabel.textColor = ThemeManager.shared.current.labelColor
        usdLabel.textColor = ThemeManager.shared.current.labelColor
        yuanLabel.textColor = ThemeManager.shared.current.labelColor
        gbpLabel.textColor = ThemeManager.shared.current.labelColor
        czkLabel.textColor = ThemeManager.shared.current.labelColor
        rubTextField.textColor = ThemeManager.shared.current.labelColor
        eurTextField.textColor = ThemeManager.shared.current.labelColor
        czechTextField.textColor = ThemeManager.shared.current.labelColor
        yuanTextField.textColor = ThemeManager.shared.current.labelColor
        usdTextField.textColor = ThemeManager.shared.current.labelColor
        poundTextField.textColor = ThemeManager.shared.current.labelColor
        //mainLabelOutlet.textColor = ThemeManager.shared.current.labelColor
        rubTextField.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        eurTextField.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        czechTextField.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        yuanTextField.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        usdTextField.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        poundTextField.backgroundColor = ThemeManager.shared.current.textFieldsBackgrounds
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(navigateToColors))
        navigationController?.navigationBar.barTintColor = ThemeManager.shared.current.navigationBackground
        navigationController?.navigationBar.tintColor = ThemeManager.shared.current.labelColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.labelColor]
        navigationItem.rightBarButtonItem?.tintColor = ThemeManager.shared.current.labelColor
        self.tabBarController?.tabBar.tintColor = ThemeManager.shared.current.itemTintColor
        self.tabBarController?.tabBar.barTintColor = ThemeManager.shared.current.navigationBackground
        self.tabBarController?.tabBar.unselectedItemTintColor = ThemeManager.shared.current.unselectedItemTintColor
    }
    
    private func configureData() {
        rubTextField.delegate = self
        eurTextField.delegate = self
        usdTextField.delegate = self
        yuanTextField.delegate = self
        czechTextField.delegate = self
        poundTextField.delegate = self
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .halfEven
        
        
        rubTextField.text = String(1)
        let eurDouble = 1 / ratesData.rates.RUB
        eurTextField.text = String(describing: formatter.string(for: eurDouble)!)
        let usdDouble = 1 / ratesData.rates.RUB * ratesData.rates.USD
        usdTextField.text = String(String(describing: formatter.string(for: usdDouble)!))
        let czechDouble = 1 / ratesData.rates.RUB * ratesData.rates.CZK
        czechTextField.text = String(describing: formatter.string(for: czechDouble)!)
        let yuanDouble = 1 / ratesData.rates.RUB * ratesData.rates.CNY
        yuanTextField.text = String(describing: formatter.string(for: yuanDouble)!)
        let poundDouble = 1 / ratesData.rates.RUB * ratesData.rates.GBP
        poundTextField.text = String(describing: formatter.string(for: poundDouble)!)
        
    }
    
    @IBAction func rubTextChange(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .halfEven
        
        if let rubText = rubTextField.text {
            let rubValue = Double(rubText)
            if  rubValue != nil {
                let czechDouble =  rubValue! / ratesData.rates.RUB * ratesData.rates.CZK
                czechTextField.text = String(describing: formatter.string(for: czechDouble)!)
                let eurDouble = rubValue! / ratesData.rates.RUB
                eurTextField.text = String(String(describing: formatter.string(for: eurDouble)!))
                let poundDouble = rubValue! / ratesData.rates.RUB * ratesData.rates.GBP
                poundTextField.text = String(describing: formatter.string(for: poundDouble)!)
                let usdDouble =  rubValue! / ratesData.rates.RUB * ratesData.rates.USD
                usdTextField.text = String(describing: formatter.string(for: usdDouble)!)
                let yuanDouble =  rubValue! / ratesData.rates.RUB * ratesData.rates.CNY
                yuanTextField.text = String(describing: formatter.string(for: yuanDouble)!)
            }
        }
    }
    
    @IBAction func eurFieldChange(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .halfEven
        
        if let eurText = eurTextField.text {
            let eurValue = Double(eurText)
            if  eurValue != nil {
                let rubDouble = eurValue! * ratesData.rates.RUB
                rubTextField.text = String(describing: formatter.string(for: rubDouble)!)
                let usdDouble = ratesData.rates.USD * eurValue!
                usdTextField.text = String(String(describing: formatter.string(for: usdDouble)!))
                let czechDouble = ratesData.rates.CZK * eurValue!
                czechTextField.text = String(describing: formatter.string(for: czechDouble)!)
                let yuanDouble = ratesData.rates.CNY * eurValue!
                yuanTextField.text = String(describing: formatter.string(for: yuanDouble)!)
                let poundDouble = ratesData.rates.GBP * eurValue!
                poundTextField.text = String(describing: formatter.string(for: poundDouble)!)
            }
        }
    }
    @IBAction func usdFieldChange(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .halfEven
        
        if let usdText = usdTextField.text {
            let usdValue = Double(usdText)
            if  usdValue != nil {
                let rubDouble = (1 / ratesData.rates.USD * ratesData.rates.RUB) * usdValue!
                rubTextField.text = String(describing: formatter.string(for: rubDouble)!)
                let eurDouble = usdValue! / ratesData.rates.USD
                eurTextField.text = String(String(describing: formatter.string(for: eurDouble)!))
                let czechDouble = (1 / ratesData.rates.USD * ratesData.rates.CZK) * usdValue!
                czechTextField.text = String(describing: formatter.string(for: czechDouble)!)
                let yuanDouble = (1 / ratesData.rates.USD * ratesData.rates.CNY) * usdValue!
                yuanTextField.text = String(describing: formatter.string(for: yuanDouble)!)
                let poundDouble = (1 / ratesData.rates.USD * ratesData.rates.GBP) * usdValue!
                poundTextField.text = String(describing: formatter.string(for: poundDouble)!)
            }
        }
    }
    
    @IBAction func yuanFieldChange(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .halfEven
        
        if let yuanText = yuanTextField.text {
            let yuanValue = Double(yuanText)
            if  yuanValue != nil {
                let rubDouble = (1 / ratesData.rates.CNY * ratesData.rates.RUB) * yuanValue!
                rubTextField.text = String(describing: formatter.string(for: rubDouble)!)
                let eurDouble = yuanValue! / ratesData.rates.CNY
                eurTextField.text = String(String(describing: formatter.string(for: eurDouble)!))
                let czechDouble = (1 / ratesData.rates.CNY * ratesData.rates.CZK) * yuanValue!
                czechTextField.text = String(describing: formatter.string(for: czechDouble)!)
                let usdDouble = (1 / ratesData.rates.CNY * ratesData.rates.USD) * yuanValue!
                usdTextField.text = String(describing: formatter.string(for: usdDouble)!)
                let poundDouble = (1 / ratesData.rates.CNY * ratesData.rates.GBP) * yuanValue!
                poundTextField.text = String(describing: formatter.string(for: poundDouble)!)
            }
        }
    }
    @IBAction func poundFieldChange(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .halfEven
        
        if let poundText = poundTextField.text {
            let poundValue = Double(poundText)
            if  poundValue != nil {
                let rubDouble = (1 / ratesData.rates.GBP * ratesData.rates.RUB) * poundValue!
                rubTextField.text = String(describing: formatter.string(for: rubDouble)!)
                let eurDouble = poundValue! / ratesData.rates.GBP
                eurTextField.text = String(String(describing: formatter.string(for: eurDouble)!))
                let czechDouble = (1 / ratesData.rates.GBP * ratesData.rates.CZK) * poundValue!
                czechTextField.text = String(describing: formatter.string(for: czechDouble)!)
                let usdDouble = (1 / ratesData.rates.GBP * ratesData.rates.USD) * poundValue!
                usdTextField.text = String(describing: formatter.string(for: usdDouble)!)
                let yuanDouble = (1 / ratesData.rates.GBP * ratesData.rates.CNY) * poundValue!
                yuanTextField.text = String(describing: formatter.string(for: yuanDouble)!)
            }
        }
    }
    @IBAction func czechFieldChange(_ sender: Any) {
       let formatter = NumberFormatter.customFormatter
        
        if let czechText = czechTextField.text {
            let czechValue = Double(czechText)
            if  czechValue != nil {
                let rubDouble = (1 / ratesData.rates.CZK * ratesData.rates.RUB) * czechValue!
                rubTextField.text = String(describing: formatter.string(for: rubDouble)!)
                let eurDouble = czechValue! / ratesData.rates.CZK
                eurTextField.text = String(String(describing: formatter.string(for: eurDouble)!))
                let poundDouble = (1 / ratesData.rates.CZK * ratesData.rates.GBP) * czechValue!
                poundTextField.text = String(describing: formatter.string(for: poundDouble)!)
                let usdDouble = (1 / ratesData.rates.CZK * ratesData.rates.USD) * czechValue!
                usdTextField.text = String(describing: formatter.string(for: usdDouble)!)
                let yuanDouble = (1 / ratesData.rates.CZK * ratesData.rates.CNY) * czechValue!
                yuanTextField.text = String(describing: formatter.string(for: yuanDouble)!)
            }
        }
    }
}


extension ExchangeRatesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}





    
    
   

