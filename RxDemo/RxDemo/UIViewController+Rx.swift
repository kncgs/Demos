//
//  UIViewController+Rx.swift
//  RxDemo
//


import UIKit
import RxSwift

extension Reactive where Base: UIViewController {

    var viewDidLoad: Observable<Void> {
        return self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in Void() }
    }
    
    var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(Base.viewWillAppear(_:))).map { $0.first as? Bool ?? false }
    }
    
    var viewDidAppear: Observable<Bool> {
        return methodInvoked(#selector(Base.viewDidAppear(_:))).map { $0.first as? Bool ?? false }
    }
}

