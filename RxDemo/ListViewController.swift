//
//  ViewController.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    private let disposedBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    convenience init(viewModel: ListViewModel) {
        self.init()
        
        self.rx.viewDidLoad.bind(to: viewModel.viewDidLoad).disposed(by: disposedBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

