//
//  SectionItem.swift
//  RxExamples
//
//  Created by jin on 2019/5/27.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

//
struct SectionType<T> {
    var header: String
    var items: [T]
}

extension SectionType: SectionModelType {
    typealias Item = T
    
    init(original: SectionType, items: [T]) {
        self = original
        self.items = items
    }
}
