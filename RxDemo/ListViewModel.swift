//
//  ListViewModel.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import Foundation
import Moya
import RxSwift


class ListViewModel: NSObject {
    
    let viewDidLoad: PublishSubject<Void> = .init()
    
    
    init(provider: RxMoyaProvider<ApiProvider>) {
        
    }
    
}
