//
//  Extensions.swift
//  RxExamples
//
//  Created by jin on 2019/5/27.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import ObjectMapper

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return String(describing: type(of: self))
    }
}

 
