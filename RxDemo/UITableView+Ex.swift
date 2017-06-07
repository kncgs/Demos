//
//  UITableView+Ex.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.

import UIKit

extension UITableView {
    
    func registerNibCell<T: UITableViewCell>(_ cell: T.Type) {
        register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
    }
    
    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: String(describing: cell))
    }
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! T
    }

}
