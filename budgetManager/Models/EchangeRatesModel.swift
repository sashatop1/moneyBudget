import Foundation

struct  ExchangeRatesModel: Decodable {
    
    struct  Rates: Decodable {
        let RUB: Double
        let CZK: Double
        let USD: Double
        let CNY: Double
        let GBP: Double
        
        enum keys: CodingKey {
            case RUB, CZK, USD, CNY, GBP
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: keys.self)
            RUB = try container.decode(Double.self, forKey: .RUB)
            CZK = try container.decode(Double.self, forKey: .CZK)
            USD = try container.decode(Double.self, forKey: .USD)
            CNY = try container.decode(Double.self, forKey: .CNY)
            GBP = try container.decode(Double.self, forKey: .GBP)
        }
    }
    
    
    let rates: Rates
    
    
    
}
