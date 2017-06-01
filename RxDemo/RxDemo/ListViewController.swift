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
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposedBag = DisposeBag()
    
    private let dataSource = RxTableViewSectionedReloadDataSource<StudentSection>()
//    private let dataSource = RxTableViewSectionedAnimatedDataSource<StudentSection>()
    
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
        configUI()
    }
    
    private func configUI() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        tableView.registerNibCell(StudentCell.self)
        dataSource.configureCell = { ds, tv, idx, model in
            let cell = tv.dequeueCell(StudentCell.self, for: idx)
            cell.config(model)
            return cell
        }
    }
    
    private func configRx(_ viewModel: ListViewModel) {
        
        tableView.rx
            .itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposedBag)
        
        
        viewModel.navigationBarTitle
            .drive(self.rx.title)
            .disposed(by: disposedBag)
        
        viewModel.loading
            .drive(HUD.rx_loading)
            .disposed(by: disposedBag)
        
        viewModel.section
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposedBag)
        
        viewModel.pushDetailViewModel
            .drive(onNext: { [unowned self] vm in
                let vc = DetailViewController(viewModel: vm)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposedBag)
    }
}

