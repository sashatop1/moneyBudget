//
//  ViewController.swift
//  budgetManager
//
//  Created by Александ on 14.10.2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

class PickerViewVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
 
    
    @IBOutlet weak var moneyTypePicker: UIPickerView!
    let array = ["Earned", "Car", "House", "Fun", "Saving"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //zalupa
        self.view.addSubview(moneyTypePicker)
        moneyTypePicker.dataSource? = self
        moneyTypePicker.delegate? = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    }
    
    




