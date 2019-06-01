//
//  BaseNavigationController.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/6/1.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit
import Hero

class BaseNavigationController: UINavigationController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        hero.isEnabled = true
        hero.modalAnimationType = .autoReverse(presenting: .fade)
        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))

    }

    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
}
