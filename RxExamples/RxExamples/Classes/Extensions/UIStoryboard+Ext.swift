//
//  UIStoryboard+Ext.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

extension UIStoryboard {
    
    static func load<T:UIViewController>(controller: T.Type) -> T {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: controller.className) as? T else {
            fatalError("请检查 `\(controller.className)` 是否存在，以及在 Main.storyboard 中 是否设置了 `Storyboard ID` 。")
        }
        return vc
    }
}
