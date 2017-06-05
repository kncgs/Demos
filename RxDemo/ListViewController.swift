//
//  ViewController.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    convenience init(viewModel: ListViewModel) {
        self.init()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

