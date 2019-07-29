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

        appearance().shadowImage = UIImage()
        appearance().tintColor = UIColor.white
        appearance().barTintColor = .master
        appearance().isTranslucent = false
        appearance().clipsToBounds = false
        appearance().backgroundColor = .master
        appearance().setBackgroundImage(UIImage(),
                                                        for: UIBarPosition.any,
                                                        barMetrics: UIBarMetrics.default)
        appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
                                                            NSAttributedString.Key.foregroundColor: UIColor.white]}
}
