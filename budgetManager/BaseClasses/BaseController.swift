//
//  BaseController.swift
//  budgetManager
//
//  Created by Александ on 30/11/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit


class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}
extension BaseController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
