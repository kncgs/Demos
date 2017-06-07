//
//  ListViewModel.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import Foundation
import Moya
import RxSwift
import RxCocoa
import RxDataSources
import RxSwiftUtilities


class ListViewModel: NSObject {
    
    let viewDidLoad: PublishSubject<Void> = .init()
    
    
    let navigationBarTitle: Driver<String>
    let loading: Driver<Bool>
    let section: Driver<[StudentSection]>
    
    
    init(provider: RxMoyaProvider<ApiProvider>) {
        
        navigationBarTitle = .just("Students")
        
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asDriver()
        
        section =
            viewDidLoad
                .flatMap {
                    provider
                        .request(.students)
                        .trackActivity(activityIndicator)
                }
                .filter(statusCode: 200)
                .mapModels(Student.self)
                .map { $0.map { $0! } }
                .map {
                    [StudentSection(items: $0)]
                }
                .asDriver(onErrorJustReturn: [])
    }
    
}
