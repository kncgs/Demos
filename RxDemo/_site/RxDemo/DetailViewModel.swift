//
//  DetailViewModel.swift
//  RxDemo
//
//  Created by redtwowolf on 08/06/2017.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import RxSwiftExt

class DetailViewModel: NSObject {
    
    let viewDidLoad: PublishSubject<Void> = .init()
    let cancelButtonDidTap: PublishSubject<Void> = .init()
    let confirmButtonDidTap: PublishSubject<Void> = .init()
    let textFieldText: PublishSubject<String?> = .init()
    
    let nameLabelText: Driver<String?>
    let confirmButtonEnabled: Variable<Bool>
    let popViewController: Variable<Void>
    let changedNameOutput: Observable<String>
    
    private let disposedBag = DisposeBag()
    
    init(_ provider: RxMoyaProvider<ApiProvider>, student: Student) {
        
        nameLabelText = .just(student.name)
        
        confirmButtonEnabled = .init(false)
        popViewController = .init()
        
        cancelButtonDidTap.bind(to: popViewController).disposed(by: disposedBag)
        confirmButtonDidTap.bind(to: popViewController).disposed(by: disposedBag)
        
        
        textFieldText
            .distinctUntilChanged { $0.0 != $0.1 }
            .map { _ in true }
            .bind(to: confirmButtonEnabled)
            .disposed(by: disposedBag)
        
        textFieldText
            .map { $0!.characters.count > 0 }
            .bind(to: confirmButtonEnabled)
            .disposed(by: disposedBag)
        
        
        changedNameOutput =
            Observable
                .combineLatest(
                    textFieldText.asObserver(),
                    confirmButtonDidTap.asObservable()
                )
                .map { $0.0 }
                .unwrap()
        
        
    }

}
