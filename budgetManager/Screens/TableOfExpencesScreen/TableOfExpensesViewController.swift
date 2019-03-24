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
    var arrayOfTypes = MoneyType.allCasesDescription() //Эти свойства нигде не используются, надо удалить
    var cellEntities = [Expense]()
    var cellIsOpened = false
    
    private lazy var sections: [TableOfExpensesSection] = {
        let array = ["one", "two", "three"]
        return [
            TableOfExpensesSection(name: "one", array: array),
            TableOfExpensesSection(name: "two", array: array),
            TableOfExpensesSection(name: "three", array: array),
            TableOfExpensesSection(name: "four", array: array)
        ]
    }()
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(TableOfExpensesHeader.self, forHeaderFooterViewReuseIdentifier: TableOfExpensesHeader.headerIdentifier)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //тут с текущей навигацией можно не вызывать reloadData так как таблица сама релоудится при первом заходе на экран
        //tableView.reloadData()
    }
    
    
    
    //MARK: - Support methods
    func getSections() -> [String] {
        return BudgetManager.allObjects().map { $0.expenseType }.unique.sorted()
    }
    
    func getSectionTitles() -> [String] {
        return getSections().map { "\($0): Total sum = \(BudgetManager.getTotalExpenses(forExpenseType: $0))" }
    }
    
    func getRowsForSection(_ section: Int) -> [Expense] {
        let currentSection = getSections()[section]
        return BudgetManager.allObjects().filter { $0.expenseType == currentSection }
    }
//    @objc func handleTap(button: UIButton) {
//        let section = button.tag
//
//        //try to close the section first by deleting the rows
//        var expenses = [BudgetManager.allObjects()[0].expenseType]
//        var indexPaths = [IndexPath]()
//        for row in expenses.indices {
//            let indexPath = IndexPath(row: row, section: section)
//            indexPaths.append(indexPath)
//            print(section, row)
//        }
//        expenses.removeAll()
//
//        //tableView.deleteRows(at: indexPaths, with: .fade)
//        print(button.tag)
//
//        var isExpanded = false
//
//        if isExpanded == false {
//            //tableView.deleteRows(at: indexPaths, with: .fade)
//            button.setTitle("Open", for: .normal)
//            isExpanded = true
//        } else if isExpanded == true {
//            //tableView.insertRows(at: indexPaths, with: .fade)
//            button.setTitle("Close", for: .normal)
//            isExpanded = false
//        } else {
//
//        }
//    }
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
        //return getRowsForSection(section).count
        return sections[section].isExpanded ? sections[section].array.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableOfExpensesCell.identifier) as! TableOfExpensesCell
        let expence = getRowsForSection(indexPath.section)[indexPath.row]
        cell.setupCell(withModel: expence)
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    //cell color
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(red: 0.22, green: 0.28, blue: 0.31, alpha: 1)
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
        header.textLabel?.text = sections[section].name
        
        header.onTap = { [weak self] in
            guard let self = self else { return }
            self.sections[section].isExpanded.toggle()
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
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

}
