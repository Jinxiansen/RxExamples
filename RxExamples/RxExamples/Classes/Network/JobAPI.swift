//
//  JobAPI.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

let jobProvider = MoyaProvider<JobAPI>(endpointClosure:MoyaProvider.JSONEndpointMapping,
                                       plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: BaseAPI.jsonResponseDataFormatter),BaseAPI.networkActivityPlugin])

// http://api.jinxiansen.com/enJob/list?page=1

enum JobAPI {
    case jobs(page: Int)
}

extension JobAPI: TargetType {
    
    var baseURL: URL {
        return BaseAPI.BaseURL
    }
    
    var path: String {
        switch self {
        case .jobs:
            return "enJob/list"
        }
    }
    
    var method: Moya.Method {
        switch self { // get
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .jobs(let page):
            return .requestParameters(parameters: ["page":page],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return BaseAPI.headers
    }
    
}
