//
//  SectionItem.swift
//  RxExamples
//
//  Created by jin on 2019/5/27.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

enum RxType {
    case tap
    case register
    case word
}

struct TableItem {
    var title:String
    var type: RxType
}

struct SectionOfTableItem {
    var header: String
    var items: [Item]
}

extension SectionOfTableItem: SectionModelType {
    typealias Item = TableItem
    
    init(original: SectionOfTableItem, items: [Item]) {
        self = original
        self.items = items
    }
}
