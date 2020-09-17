//
//  ClipController.swift
//  RxExamples
//
//  Created by 晋先森 on 2020/9/16.
//  Copyright © 2020 晋先森. All rights reserved.
//

import UIKit

class ClipController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Clip"
        view.backgroundColor = .white
        view.addSubview(textLabel)
        view.addSubview(closeButton)
    }
    
    lazy var closeButton = UIButton(type: .system).then {
        $0.setTitle("Close", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.frame = .init(x: 15, y: textLabel.frame.maxY + 20, width: view.width - 30, height: 50)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = .main
        $0.cornerRadius = 10.0
        $0.hero.id = "clipID"
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    lazy var textLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 20, weight: .medium)
        $0.text = Const.text
        $0.numberOfLines = 0
        let size = $0.sizeThatFits(.init(width: view.width - 30, height: CGFloat.greatestFiniteMagnitude))
        $0.frame = CGRect(x: 15, y: 20, width: size.width, height: size.height)
    }

    @objc func closeButtonTapped() {
        pop()
    }

}

extension ClipController {
    
    enum Const {
        static let text = "\tAn app clip is a lightweight version of your app that offers some of its functionality when and where people need it. With Xcode, you can add an app clip target to your app’s project, share code and assets between the app clip and the full app, and build, run, and debug your app clip.\n\tTo launch an app clip, users perform an invocation, for example, by scanning an NFC tag or a visual code. "
    }
}
