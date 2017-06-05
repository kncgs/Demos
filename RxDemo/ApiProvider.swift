//
//  ApiProvider.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.


import Foundation
import Moya


public enum ApiProvider {
    case students
}

extension ApiProvider: TargetType {
    
    public var baseURL: URL { return URL(string: "")! }
    
    public var path: String {
        switch self {
        case .students:
            return ""
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var parameters: [String: Any]? {
        return [:]
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .request
    }
    
    public var validate: Bool {
        return false
    }

}
