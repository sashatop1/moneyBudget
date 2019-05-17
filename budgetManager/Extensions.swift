import Foundation

extension Array where Element: Hashable {
    var unique: [Element] {
        return self.reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}
