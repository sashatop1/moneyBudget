//
//  TableView.swift
//  budgetManager
//
//  Created by Александ on 19/10/2018.
//  Copyright © 2018 Александ. All rights reserved.
//

import UIKit

/*
 класс не стоит называть "TableView" так как TableView это уже название нативного UI эелемента
 нужно более понятное и емкое название
 */
class TableOfExpensesViewController: UIViewController {
    
    /*
     "// MARK: -" используется для логического разделения сегментов кода друг от друга
     в самом коде и сверху в навигаторе (нажми на  С TableOfExpencesViewController сверху)
     */
    
    // MARK: - Properties
    
//    private lazy var sections: [TableOfExpensesSection] = {
//        let array = ["one", "two", "three"]
//        return [
//            TableOfExpensesSection(name: "one", array: array),
//            TableOfExpensesSection(name: "two", array: array),
//            TableOfExpensesSection(name: "three", array: array),
//            TableOfExpensesSection(name: "four", array: array),
//            TableOfExpensesSection(name: "five", array: array),
//            TableOfExpensesSection(name: "six", array: array)
//        ]
//
//        //сделать сгруппированный массив секций
//
//        // () в конце условия означают, что этот блок выполняется
//    }()
    
    
    
    var groupedSections: [TableOfExpensesSection] {
        let sections = BudgetManager.allObjects()
        let names = sections.map { $0.expenseType }.unique
        return names.map { group -> TableOfExpensesSection in
            let correspondingSections = sections.filter { $0.expenseType == group }
            return TableOfExpensesSection(name: group, array: correspondingSections)
        }
    }
    
    
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(TableOfExpensesHeader.self, forHeaderFooterViewReuseIdentifier: TableOfExpensesHeader.headerIdentifier)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    
    
    //MARK: - Support methods
    func getSections() -> [String] {
        let array = BudgetManager.allObjects().map { $0.expenseType }.unique.sorted()
        return array
    }
    
    func getSectionTitles() -> [String] {
        return getSections().map { "\($0): Total sum = \(BudgetManager.getTotalExpenses(forExpenseType: $0))" }
    }
    
    func getRowsForSection(_ section: Int) -> [Expense] {
        let currentSection = getSections()[section]
        return BudgetManager.allObjects().filter { $0.expenseType == currentSection }
    }
}

/*
 estension так же можно использовать для логического разделения.
 обычно в 1 extension реализация 1 функционала/протокола
 */

// MARK: - UITableViewDelegate & UITableViewDataSource
extension TableOfExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getSections().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return getSectionTitles()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupedSections[section].isExpanded == true { return getRowsForSection(section).count }
        else {
            return 0
        }
    }
    
    //+colorCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableOfExpensesCell.identifier) as! TableOfExpensesCell
        let expence = getRowsForSection(indexPath.section)[indexPath.row]
        cell.setupCell(withModel: expence)
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        return cell
    }
    
    //deletebutton
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            BudgetManager.deleteObject(object: getRowsForSection(indexPath.section)[indexPath.row])
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableOfExpensesHeader.headerIdentifier) as! TableOfExpensesHeader
        header.setupHeader()
        header.textLabel?.text = self.groupedSections[section].name
        var needToogle = groupedSections[section].isExpanded
        header.onTap = { [weak self] in
            guard let self = self else { return }
            needToogle.toggle()
            self.tableView.reloadSections(IndexSet(arrayLiteral: section), with: .fade)
        }
        return header
    
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

}
