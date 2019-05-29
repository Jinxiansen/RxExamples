//
//  BaseController.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.groupTableViewBackground
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}


class BaseNavigationController: UINavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
