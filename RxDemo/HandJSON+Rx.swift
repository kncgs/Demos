//
//  HandJSON+Rx.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import HandyJSON
import Result
import RxSwift
import RxCocoa


enum MyError: Error {
    case noElements
}

extension HandyJSON {

    func filterError() -> Result<HandyJSON, MyError> {
        guard let _ = toJSON() else {
            return .failure(.noElements)
        }
        return .success(self)
    }
}



extension ObservableType where E: HandyJSON {
    
    func filterError() -> Observable<E> {
        return flatMap { (model) -> Observable<E> in
            return Observable.create({ (observer) -> Disposable in
                let result = model.filterError()
                if case .success(_) = result {
                    observer.onNext(model)
                    observer.onCompleted()
                }
                if case .failure(let err) = result {
                    observer.onError(err)
                }
                return Disposables.create()
            })
        }
    }
    
//    func filterIgnoreError() -> <#return type#> {
//        <#function body#>
//    }
    
}



