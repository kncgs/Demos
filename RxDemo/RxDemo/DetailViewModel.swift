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
    let ageLabelText: Driver<String?>
    let confirmButtonEnabled: Variable<Bool> = .init(false)
    let popViewController: Driver<Void>
    
    private let disposedBag = DisposeBag()
    
    init(_ provider: RxMoyaProvider<ApiProvider>, student: Student) {
        
        nameLabelText = .just(student.name)
        ageLabelText = .just("\(student.age ?? 0)")
        
        popViewController = cancelButtonDidTap.asDriverOnErrorJustComplete()
        
        
        textFieldText
            .distinctUntilChanged { $0.0 != $0.1 }
            .map { _ in true }
            .bind(to: confirmButtonEnabled)
            .disposed(by: disposedBag)
        
        textFieldText
            .map { $0!.characters.count > 0 }
            .bind(to: confirmButtonEnabled)
            .disposed(by: disposedBag)
        
        Observable.combineLatest(textFieldText.asObserver(), confirmButtonDidTap.asObservable())
        .subscribe(onNext: { (data) in
            print("===\(data.0)")
        })
        .disposed(by: disposedBag)
        
    }

}
