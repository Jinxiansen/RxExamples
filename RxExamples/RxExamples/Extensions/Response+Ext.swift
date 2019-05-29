//
//  Response+Ext.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation



extension Response {
    
    func toResult() -> VResult {
        guard let r = try? mapObject(VResult.self) else {
            return VResult.dataError()
        }
        return r
    }
}
