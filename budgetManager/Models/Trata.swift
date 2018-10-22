//
//  UserPickVCViewController.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

//название рофл)) лучше переименовать на энглиш, допустим expense + переименовать свойства
class Trata {
    var summaTrati: Double
    var name: String
    
    init(amountOfUserPick: Double, userPick: String) {
        self.summaTrati = amountOfUserPick
        self.name = userPick
    }
    
}
