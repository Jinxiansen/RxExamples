//
//  UserAPI.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

enum UserAPI {
    case register(account: String,password: String)
    case userInfo
    
}

let UserProvider = MoyaProvider<UserAPI>(endpointClosure:MoyaProvider.JSONEndpointMapping,
                                         plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: BaseAPI.jsonResponseDataFormatter),BaseAPI.networkActivityPlugin])

extension UserAPI: TargetType {
    var baseURL: URL {
        return BaseAPI.BaseURL
    }
    
    var path: String {
        switch self {
        case .register:
            return "users/register"
        case .userInfo:
            return "users/getUserInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .register(account, password):
            return .requestParameters(parameters: ["account":account,"password":password],
                                      encoding: URLEncoding.default)
        case .userInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return BaseAPI.headers
    }
    
}
 
