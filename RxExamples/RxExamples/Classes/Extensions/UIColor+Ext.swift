//
//  UIColor+Ext.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/5/30.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

extension UIColor {

    class var main: UIColor {
        return UIColor(red: 48/255.0, green: 175/255.0, blue: 145/255.0, alpha: 1)
    }

    class var c78: UIColor {
        return UIColor(hexString: "787f87")!
    }
    
    class var lightBlue: UIColor {
        return UIColor(hexString: "189cfb")!
    }

    class var bg: UIColor {
        return UIColor.groupTableViewBackground
    }

}
