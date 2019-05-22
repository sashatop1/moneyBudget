import Foundation

class ColorManager {
    
    
    enum СolorState {
        case black
        case white
        case fun
        
        
        var description: ThemeProtocol {
            switch self {
            case .black: return DarkTheme()
            case .white: return LightTheme()
            case .fun: return FunTheme()
            }
            
        }
    }
}