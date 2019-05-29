//
//  WordApi.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation



//let WordProvider = MoyaProvider<WordApi>(endpointClosure:MoyaProvider.JSONEndpointMapping,
//                                         plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: BaseApi.jsonResponseDataFormatter),BaseApi.networkActivityPlugin])

let WordProvider = MoyaProvider<WordApi>(endpointClosure:MoyaProvider.JSONEndpointMapping,
                                         plugins: [BaseApi.networkActivityPlugin])

// http://api.jinxiansen.com  基于 Swift 服务端的 渣渣 api ，写的比较早，比较不规范，凑合着查。🌝
enum WordApi { // 其实这几个 api 去年写的时候数据一次给出的，没支持分页。
    case character(text: String,page: Int) // 查字
    case word(text: String,page: Int) // 查词语
    case idiom(text: String,page: Int) // 成语
    case xiehouyuInChinese(text: String,page: Int) // 歇后语
}

extension WordApi: TargetType {
    
    var baseURL: URL {
        return BaseApi.BaseURL
    }
    
    var path: String {
        switch self {
        case .character:
            return "words/word"
        case .word:
            return "words/ci"
        case .idiom:
            return "words/idiom"
        case .xiehouyuInChinese:
            return "words/xxidiom"
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
        case .word(let text,let page),
             .character(let text,let page),
             .idiom(let text,let page),
             .xiehouyuInChinese(let text,let page):
            return .requestParameters(parameters: ["str":text,"page":page],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return BaseApi.headers
    }
    
}
