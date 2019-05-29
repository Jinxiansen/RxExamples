//
//  UserApi.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

enum UserApi {
    case register(account: String,password: String)
    case userInfo
    
}

let UserProvider = MoyaProvider<UserApi>(endpointClosure:MoyaProvider.JSONEndpointMapping,
                                         plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: jsonResponseDataFormatter),networkActivityPlugin])

extension UserApi: TargetType {
    var baseURL: URL {
        #if DEBUG
            return try! "http://api.jinxiansen.com/".asURL()
        #else
            return try! "http://api.jinxiansen.com/".asURL() //
        #endif
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
            return .requestParameters(parameters: ["account":account,"password":password], encoding: URLEncoding.default)
        case .userInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type":"application/x-www-form-urlencoded; charset=utf-8"]
    }
    
}

let networkActivityPlugin = NetworkActivityPlugin { (change,_)  -> () in
    switch(change){
    case .ended:
        Async.main {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    case .began:
        Async.main {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
}

struct Async {
    
    static func main(_ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
}

func jsonResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}
