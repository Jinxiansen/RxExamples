//
//  Response.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya_ObjectMapper

struct APIResult: Mappable {
    
    var status: Int = -1
    var message: String?
    var data: Any?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
    
    static func netError() -> APIResult {
        return APIResult(JSON: ["status":"-1","message":ErrorType.networkError.rawValue])!
    }

    static func parseError() -> APIResult {
        return APIResult(JSON: ["status":"-2","message":ErrorType.dataParseError.rawValue])!
    }

    var isOk: Bool {
        return status == 0 // maybe is 200
    }
}

extension APIResult {
    
    func mapObjects<T: Mappable>(_ map: T.Type,context: MapContext? = nil) throws -> [T] {
        guard isOk else {
            throw ResultError.parseError(self.message ?? ErrorType.serverError.rawValue)
        }
        guard let objects = Mapper<T>(context: context).mapArray(JSONObject: self.data) else {
            throw ResultError.parseError(ErrorType.dataParseError.rawValue)
        }
        
        return objects
    }
    
    func mapObject<T: Mappable>(_ map: T.Type,context: MapContext? = nil) throws -> T {
        guard isOk else {
            throw ResultError.parseError(self.message ?? ErrorType.serverError.rawValue)
        }
        guard let object = Mapper<T>(context: context).map(JSONObject: self.data) else {
            throw ResultError.parseError(ErrorType.dataParseError.rawValue)
        }
        
        return object
    }
    
}



struct Token: Mappable {
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        accessToken <- map["accessToken"]
    }
    
    var accessToken: String = ""
    
}
