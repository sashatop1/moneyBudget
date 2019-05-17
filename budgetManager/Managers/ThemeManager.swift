import UIKit

class ThemeManager {
    
    static let shared = ThemeManager()
    
    
    private init(){
        
    }
    
    var current: ThemeProtocol = {
        var theme: ThemeProtocol = DarkTheme()
        if UserDefaults.standard.bool(forKey: "dark") {
            theme = DarkTheme()
        } else if UserDefaults.standard.bool(forKey: "white") {
            theme = LightTheme()
        } else if UserDefaults.standard.bool(forKey: "fun"){
            theme = FunTheme()
        }
        return theme
        
    }()
    
    
    
}
