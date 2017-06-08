//
//  Observable+Ex.swift
//  RxDemo
//
//  Created by redtwowolf on 08/06/2017.

import RxSwift
import RxCocoa

extension ObservableType {

    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in .empty() }
    }
}
