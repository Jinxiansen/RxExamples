//
//  WordModel.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya_ObjectMapper

struct JobItem: Mappable {
    
    var company : String?
    var exp : String?
    var id : Int?
    var jobId : String?
    var loc : String?
    var more : String?
    var publisher : String?
    var salary : String?
    var title : String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        company <- map["company"]
        exp <- map["exp"]
        id <- map["id"]
        jobId <- map["jobId"]
        loc <- map["loc"]
        more <- map["more"]
        publisher <- map["publisher"]
        salary <- map["salary"]
        title <- map["title"]
    }
    
}
