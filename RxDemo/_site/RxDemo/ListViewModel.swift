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
    let itemSelected: PublishSubject<IndexPath> = .init()
//    let itemSelected: PublishSubject<Student> = .init()
    
    
    
    let navigationBarTitle: Driver<String>
    let loading: Driver<Bool>
    let section: Driver<[StudentSection]>
    let showResponseHUD: Driver<RxHUDValue>
    let pushDetailViewModel: Driver<DetailViewModel>
    
    
    init(provider: RxMoyaProvider<ApiProvider>) {
        
        let disposeBag = DisposeBag()
        
        navigationBarTitle = .just("Students")
        
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asDriver()
        
        let successHUD = RxHUDValue(type: .label("获取数据成功"))
        let failHUD = RxHUDValue(type: .label("发生错误"))
        
        let request =
            viewDidLoad
                .flatMap {
                    provider
                        .request(.students)
                        .trackActivity(activityIndicator)
                }
                .shareReplay(1)
        
        
        showResponseHUD =
            request
                .filter(statusCode: 200)
                .map { _ in successHUD }
                .asDriver(onErrorJustReturn: failHUD)
        
        section =
            request
                .filter(statusCode: 200)
                .mapModels(Student.self)
                .map { $0.map { $0! } }
                .map {
                    [StudentSection(items: $0)]
                }
                .asDriver(onErrorJustReturn: [])
        
        
        let changedNameReceiver: Variable<String> = .init("")
        
//        pushDetailViewModel =
//            itemSelected
//                .map { DetailViewModel(provider, student: $0) }
//                .asDriverOnErrorJustComplete()
        
        let selectedItem =
            Observable
                .combineLatest(
                    section.asObservable(),
                    itemSelected.asObserver()
                )
                .filter { !$0.0.isEmpty }
                .map { $0.0[0].items[$0.1.row] }
                .shareReplay(1)
        
        pushDetailViewModel =
                selectedItem
                .map { student -> DetailViewModel in
                    let viewModel = DetailViewModel(provider, student: student)
                    
                    viewModel.changedNameOutput
                        .bind(to: changedNameReceiver)
                        .disposed(by: disposeBag)
                    
                    return viewModel
                }
                .asDriverOnErrorJustComplete()
        
        
        Observable
            .combineLatest(
                changedNameReceiver.asObservable(),
                section.asObservable(),
                itemSelected.asObservable()
            )
            .subscribe(onNext: { data in
                var items = data.1[0].items
                var item = items[data.2.row]
                item.name = data.0
                items.remove(at: data.2.row)
                items.insert(item, at: data.2.row)
            })
            .disposed(by: disposeBag)
        
            
    }
    
}
