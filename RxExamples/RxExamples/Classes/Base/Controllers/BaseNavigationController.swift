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

        hero.isEnabled = true
        hero.modalAnimationType = .autoReverse(presenting: .fade)
        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))
        //        hero.navigationAnimationType = .autoReverse(presenting: .push(direction: .left))

        Hero.shared.containerColor = UIColor.white

    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

