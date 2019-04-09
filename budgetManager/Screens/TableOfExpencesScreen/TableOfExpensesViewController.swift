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
        var groupedSections: [TableOfExpensesSection] = {
        let sections = BudgetManager.allObjects()
        let names = sections.map { $0.expenseType }.unique
        return names.map { group -> TableOfExpensesSection in
            let correspondingSections = sections.filter { $0.expenseType == group }
            return TableOfExpensesSection(name: group, array: correspondingSections)
        }
    }()
    //=(перед блоком) и  () в конце условия означают, что этот блок выполняется
    
    
    
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
        self.navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    
    
    //MARK: - Support methods
   func formTitleForSection(section: String) -> String {
        return "\(section): Total sum = \(BudgetManager.getTotalExpenses(forExpenseType: section))"
    }
    
    
}
// MARK: - UITableViewDelegate & UITableViewDataSource
extension TableOfExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return formTitleForSection(section: groupedSections[section].name)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedSections[section].isExpanded ? groupedSections[section].array.count : 0
    }
    
    //+colorCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableOfExpensesCell.identifier) as! TableOfExpensesCell
        let expense = groupedSections[indexPath.section].array[indexPath.row]
        cell.setupCell(withModel: expense)
        return cell
    }
    
    //deletebutton
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            BudgetManager.deleteObject(object: groupedSections[indexPath.section].array[indexPath.row])
            groupedSections[indexPath.section].array.remove(at: indexPath.row)
            if groupedSections[indexPath.section].array.isEmpty {
                groupedSections.remove(at: indexPath.section)
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableOfExpensesHeader.headerIdentifier) as! TableOfExpensesHeader
        header.setupHeader()
        header.onTap = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.groupedSections[section].isExpanded.toggle()
            weakSelf.tableView.reloadSections(IndexSet(arrayLiteral: section), with: .fade)
        }
        return header
    
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableOfExpensesHeader.headerIdentifier) as! TableOfExpensesHeader
        header.textLabel?.textColor = .black
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
