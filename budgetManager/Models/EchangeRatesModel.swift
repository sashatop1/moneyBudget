import Foundation

struct ExchangeRatesModel: Decodable {
    
    let rates: Rates
    
    init() {
        rates = Rates()
    }
}

extension ExchangeRatesModel {
    
    struct Rates: Decodable {
        let RUB: Double
        let CZK: Double
        let USD: Double
        let CNY: Double
        let GBP: Double
        
        enum Keys: CodingKey {
            case RUB, CZK, USD, CNY, GBP
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            RUB = try container.decode(Double.self, forKey: .RUB)
            CZK = try container.decode(Double.self, forKey: .CZK)
            USD = try container.decode(Double.self, forKey: .USD)
            CNY = try container.decode(Double.self, forKey: .CNY)
            GBP = try container.decode(Double.self, forKey: .GBP)
        }
        
        init() {
            RUB = 0
            CZK = 0
            USD = 0
            CNY = 0
            GBP = 0
        }
    }
}

