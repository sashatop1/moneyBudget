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
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return getRowsForSection(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableOfExpensesCell.identifier) as! TableOfExpensesCell
        let expence = getRowsForSection(indexPath.section)[indexPath.row]
        cell.setupCell(withModel: expence)
        return cell
    }

    //deletebutton
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            BudgetManager.deleteObject(object: getRowsForSection(indexPath.section)[indexPath.row])
            tableView.reloadData()
        }
}

}

