//
//  MoyaResponse+Rx.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.
//

import Foundation
import Moya
import HandyJSON
import RxSwift


extension ObservableType where E == Response {
    public func mapModels<T: HandyJSON>(_ type: T.Type) -> Observable<[T?]> {
        return flatMap { Observable.just(try $0.mapModels(type)) }
    }
}


extension Response {
    public func mapModels<T: HandyJSON>(_ type: T.Type) throws -> [T?] {
        let json = String(data: data, encoding: .utf8)
        guard let result = JSONDeserializer<T>.deserializeModelArrayFrom(json: json) else {
            throw MoyaError.jsonMapping(self)
        }
        return result
    }
}
