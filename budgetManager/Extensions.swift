//
//  Extensions.swift
//  budgetManager
//
//  Created by leonid on 31.10.2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var unique: [Element] {
        return self.reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}
