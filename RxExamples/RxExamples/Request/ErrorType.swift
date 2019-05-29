//
//  ServerErrorType.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case netError = "网络异常，请稍后重试"
    case dataError = "获取数据失败，请稍后重试"
    case tokenInValid = "Token 失效，请重新登录"
    case parseError = "数据解析失败"
    case serverError = "接口返回错误"
}


enum ResultError: Swift.Error {
    case parseError(String)
    case parseResultError(VResult)
}

extension ResultError: LocalizedError {
    
    public var message: String? {
        
        switch self {
        case .parseResultError(let result):
            return result.message
        case .parseError(let message):
            return message
        }
    }
}
