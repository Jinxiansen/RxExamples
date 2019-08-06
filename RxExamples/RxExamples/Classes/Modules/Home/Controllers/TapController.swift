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
        
        tapButton.hero.id = "backID"
        
        tapButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.push(controller: UIStoryboard.load(controller: BackController.self))
        }).disposed(by: rx.disposeBag)
        
    }
 
}
