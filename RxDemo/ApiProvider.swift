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
    
    // http://localhost:3000/students
    public var baseURL: URL { return URL(string: "http://localhost:3000")! }
    
    public var path: String {
        switch self {
        case .students:
            return "/students"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return nil
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
