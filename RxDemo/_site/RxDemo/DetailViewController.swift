//
//  DetailViewController.swift
//  RxDemo
//
//  Created by redtwowolf on 08/06/2017.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let disposedBag = DisposeBag()
    
    convenience init(viewModel: DetailViewModel) {
        self.init(nibName: "DetailViewController", bundle: nil)
        
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
    }
    
    private func configRx(_ viewModel: DetailViewModel) {
        
        cancelButton.rx
            .tap
            .bind(to: viewModel.cancelButtonDidTap)
            .disposed(by: disposedBag)
        
        confirmButton.rx
            .tap
            .bind(to: viewModel.confirmButtonDidTap)
            .disposed(by: disposedBag)
        
        textField.rx
            .text
            .bind(to: viewModel.textFieldText)
            .disposed(by: disposedBag)
        
        viewModel.nameLabelText
            .drive(nameLabel.rx.text)
            .disposed(by: disposedBag)
        
        
        viewModel.nameLabelText
            .drive(textField.rx.text)
            .disposed(by: disposedBag)
        
        viewModel.confirmButtonEnabled
            .asDriver()
            .drive(confirmButton.rx.isEnabled)
            .disposed(by: disposedBag)
        
        viewModel.popViewController
            .asDriver()
            .skip(1)
            .drive(onNext: { [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposedBag)
    }

}
