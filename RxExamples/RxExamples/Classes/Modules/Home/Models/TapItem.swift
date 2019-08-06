//
//  TapItem.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/7/31.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

enum RxType {
    case tap
    case register
    case word
}

struct TapItem {
    var title:String
    var type: RxType
}
