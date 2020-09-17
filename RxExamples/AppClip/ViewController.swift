//
//  ViewController.swift
//  AppClip
//
//  Created by 晋先森 on 2020/9/16.
//  Copyright © 2020 晋先森. All rights reserved.
//

import UIKit
import Hero
import StoreKit

class ViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "AppClip"
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(showClipButton)
        view.addSubview(overlayButton)
    }
    
    
    lazy var showClipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = .init(x: 100, y: 150, width: view.width - 200, height: 45)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .main
        button.cornerRadius = 5.0
        button.addTarget(self, action: #selector(showClipButtonTapped), for: .touchUpInside)
        button.hero.id = "clipID"
        return button
    }()
    
    lazy var overlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("App Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = .c78
        button.cornerRadius = 5.0
        button.frame = CGRect(x: (view.frame.width - 200)/2, y: showClipButton.frame.maxY + 30, width: 200, height: 40)
        button.addTarget(self, action: #selector(showDownloadPreview), for: .touchUpInside)
        
        return button
    }()

}

extension ViewController {
    
    @objc func showClipButtonTapped() {
        push(controller: ClipController())
    }
    
    @objc func showDownloadPreview() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let config = SKOverlay.AppConfiguration(appIdentifier: "com.jinxiansen.RxExamples", position: .bottom)
        let overlay = SKOverlay(configuration: config)
        overlay.delegate = self
        overlay.present(in: scene)
    }
}


extension ViewController : SKOverlayDelegate {
    
    func storeOverlayDidFailToLoad(_ overlay: SKOverlay, error: Error) {
     
    }
    
    func storeOverlayWillStartDismissal(_ overlay: SKOverlay, transitionContext: SKOverlay.TransitionContext) {
       
    }
    
    func storeOverlayWillStartPresentation(_ overlay: SKOverlay, transitionContext: SKOverlay.TransitionContext) {
        
    }
    
    func storeOverlayDidFinishDismissal(_ overlay: SKOverlay, transitionContext: SKOverlay.TransitionContext) {
        logInfo("SKOverlay DidFinishDismissal")
    }
    
    func storeOverlayDidFinishPresentation(_ overlay: SKOverlay, transitionContext: SKOverlay.TransitionContext) {
        logInfo("SKOverlay DidFinishPresentation")
    }

}
