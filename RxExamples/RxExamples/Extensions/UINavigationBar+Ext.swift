//
//  UINavigationBar+Ext.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation


extension UINavigationBar {
    
    static func configAppearance() {
        
        let color = UIColor(red: 48/255.0, green: 175/255.0, blue: 145/255.0, alpha: 1)
        appearance().shadowImage = UIImage()
        appearance().tintColor = UIColor.white
        appearance().barTintColor = color
        appearance().isTranslucent = false
        appearance().clipsToBounds = false
        appearance().backgroundColor = color
        appearance().setBackgroundImage(UIImage(),
                                                        for: UIBarPosition.any,
                                                        barMetrics: UIBarMetrics.default)
        appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
                                                            NSAttributedString.Key.foregroundColor: UIColor.white]}
}
