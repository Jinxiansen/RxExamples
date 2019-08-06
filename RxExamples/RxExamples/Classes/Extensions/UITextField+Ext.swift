//
//  UITextField+Ext.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/7/31.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

extension UITextField {
    
    func asDriver() -> Driver<String> {
        return rx.text.orEmpty.asDriver()
    }
}
