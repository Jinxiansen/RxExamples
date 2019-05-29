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

struct Word: Mappable {
    
    var ci: String = ""
    var explanation: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        ci <- map["ci"]
        explanation <- map["explanation"]
    }
    
}


// Mark: Section

struct WordSection {
    var items: [Item]
}

extension WordSection: SectionModelType {
    
    typealias Item = Word
    
    init(original: WordSection, items: [WordSection.Item]) {
        self = original
        self.items = items
    }
}
