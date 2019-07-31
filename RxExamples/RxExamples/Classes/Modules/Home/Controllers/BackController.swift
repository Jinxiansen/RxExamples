//
//  BackController.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/8/1.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit

class BackController: BaseController {

    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Back"
        
        backButton.hero.id = "backID"
        
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.pop()
        }).disposed(by: rx.disposeBag)
        
    }
    
}
