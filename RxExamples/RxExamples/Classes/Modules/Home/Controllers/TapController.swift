//
//  TapController.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit
import Hero

class TapController: BaseController {

    @IBOutlet weak var tapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tapButton.hero.id = "abcd"
        
        tapButton.rx.tap.do(onNext: { _ in
            SVProgressHUD.show()
        }).delay(1.5, scheduler: MainScheduler.instance).subscribe(onNext: { _ in
            SVProgressHUD.showSuccess(withStatus: "请求成功")
        }).disposed(by: rx.disposeBag)
        
    }
 
}
