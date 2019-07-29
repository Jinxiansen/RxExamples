//
//  ServerErrorType.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case networkError = "网络异常，请稍后重试"
    case getDataFailed = "获取数据失败，请稍后重试"
    case tokenInValid = "Token 失效，请重新登录"
    case dataParseError = "数据解析失败"
    case serverError = "数据返回错误"
    case noData = "No Data"
    case notFound = "Search result is empty"
    case notFoundDapp = "Unable to find DApp"
    case noNotifications = "no-notifications"

}

enum ResultError: Swift.Error {
    case parseError(String)
    case parseResultError(APIResult)
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

    static func error(type: ErrorType) -> ResultError {
        return ResultError.parseError(type.rawValue)
    }

    //
    static var getDataFailed: ResultError {
        return error(type: .getDataFailed)
    }
    static var noData: ResultError {
        return error(type: .noData)
    }
    static var notFound: ResultError {
        return error(type: .notFound)
    }
    static var notFoundDapp: ResultError {
        return error(type: .notFoundDapp)
    }
    static var noNotifications: ResultError {
        return error(type: .noNotifications)
    }
}
