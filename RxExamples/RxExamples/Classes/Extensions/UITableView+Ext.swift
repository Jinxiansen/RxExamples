//
//  TableView+Ext.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

extension UITableView {
    
    func registerCell<T: UITableViewCell>(class cell: T.Type) {
        register(cell.self, forCellReuseIdentifier: cell.className)
    }
    
    func dequeueReusable<T: UITableViewCell>(class cell: T.Type) -> T {
        guard let aCell = dequeueReusableCell(withIdentifier: cell.className) as? T else {
            fatalError("Couldn't find UITableViewCell for \(cell.className), make sure the cell is registered with table view")
        }
        return aCell
    }
    
    func registerCell<T: UITableViewCell>(nib cell: T.Type) {
        register(UINib(nibName: cell.className, bundle: nil), forCellReuseIdentifier: cell.className)
    }
}
