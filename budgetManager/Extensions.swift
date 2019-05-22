import Foundation

extension Array where Element: Hashable {
    var unique: [Element] {
        return self.reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}

extension NumberFormatter {
    static var customFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .halfEven
        
        return formatter
    }
}
