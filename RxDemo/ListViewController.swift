//
//  ViewController.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import PKHUD

class ListViewController: UIViewController {
    
    private let disposedBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    private let dataSource = RxTableViewSectionedReloadDataSource<StudentSection>()
    
    
    convenience init(viewModel: ListViewModel) {
        self.init(nibName: "ListViewController", bundle: nil)
        
        self.rx
            .viewDidLoad
            .subscribe(onNext: { [weak self] _ in
                self?.configRx(viewModel)
            })
            .disposed(by: disposedBag)
        
        self.rx
            .viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposedBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(StudentCell.self)
        tableView.tableFooterView = UIView()
        
        dataSource.configureCell = { ds, tv, idx, model in
            let cell = tv.dequeueCell(StudentCell.self, for: idx)
            cell.config(model)
            return cell
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configRx(_ viewModel: ListViewModel) {
        
        viewModel.navigationBarTitle
            .drive(self.rx.title)
            .disposed(by: disposedBag)
        
        viewModel.loading
            .drive(HUD.rx_loading)
            .disposed(by: disposedBag)
        
        viewModel.section
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposedBag)
    }


}

