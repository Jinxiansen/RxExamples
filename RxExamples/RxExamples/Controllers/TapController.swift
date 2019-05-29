//
//  TapController.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit

class TapController: BaseController {

    @IBOutlet weak var tapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapButton.rx.tap.do(onNext: { _ in
            SVProgressHUD.show()
        }).delay(1.5, scheduler: MainScheduler.instance).subscribeNext({ _ in
            SVProgressHUD.showSuccess(withStatus: "请求成功")
        }).disposed(by: rx.disposeBag)
        
    }
 
}
