//
//  TableView.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var arrayOfTypes = [PickerViewVC.MoneyType.allCasesDescription()]
    var cellEntities = [Trata]()
    var object1: UITableView?
    var object2: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TableViewBudget: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BudgetManager.shared.savedObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let singleTrata = BudgetManager.shared.savedObjects[indexPath.row]
        return cell
    }
    
}




