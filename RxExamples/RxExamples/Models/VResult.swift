//
//  Response.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import ObjectMapper

struct VResult: Mappable {
    
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
    
    static func netError() -> VResult {
        return VResult(JSON: ["status":"-1","message":ErrorType.netError.rawValue])!
    }
    static func dataError() -> VResult {
        return VResult(JSON: ["status":"-2","message":ErrorType.dataError.rawValue])!
    }
    
    static func parseError() -> VResult {
        return VResult(JSON: ["status":"-3","message":ErrorType.parseError.rawValue])!
    }
}



extension VResult {
    
    func mapObjects<T: Mappable>(_ map: T.Type,context: MapContext? = nil) throws -> [T] {
        guard self.status == 0 else {
            throw ResultError.parseError(self.message ?? ErrorType.serverError.rawValue)
        }
        guard let objects = Mapper<T>(context: context).mapArray(JSONObject: self.data) else {
            throw ResultError.parseError(ErrorType.parseError.rawValue)
        }
        
        return objects
    }
    
    func mapObject<T: Mappable>(_ map: T.Type,context: MapContext? = nil) throws -> T {
        guard self.status == 0 else {
            throw ResultError.parseError(self.message ?? ErrorType.serverError.rawValue)
        }
        guard let object = Mapper<T>(context: context).map(JSONObject: self.data) else {
            throw ResultError.parseError(ErrorType.parseError.rawValue)
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
