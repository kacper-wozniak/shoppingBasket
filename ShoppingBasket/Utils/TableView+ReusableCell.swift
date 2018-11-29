//
//  TableView+ReusableCell.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import UIKit

extension UITableView {

    func register(cell: ReusableCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }

    func dequeue<Cell: ReusableCell>(cell: Cell.Type) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.identifier) as? Cell else {
            fatalError("\(Cell.identifier) must be registered.")
        }
        return cell
    }

}
