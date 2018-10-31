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
    
    // MARKL - @IBOutlets
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
}

/*
 estension так же можно использовать для логического разделения.
 обычно в 1 extension реализация 1 функционала/протокола
 */

// MARK: - UITableViewDelegate & UITableViewDataSource
extension TableOfExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BudgetManager.allObjects().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableOfExpensesCell.identifier) as! TableOfExpensesCell
        let expence = BudgetManager.allObjects()[indexPath.row]
        cell.setupCell(withEntity: expence)
        return cell
    }
}




