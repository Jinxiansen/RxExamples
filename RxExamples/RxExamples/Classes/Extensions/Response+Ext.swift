//
//  Response+Ext.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation



extension Response {
    
    func toResult() -> APIResult {
        guard let r = try? mapObject(APIResult.self) else {
            return APIResult.parseError()
        }
        return r
    }
}
