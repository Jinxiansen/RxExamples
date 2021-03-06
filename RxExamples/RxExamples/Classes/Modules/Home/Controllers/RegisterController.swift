//
//  RegisterController.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit

class RegisterController: BaseController {
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
        accountField.rx.text.orEmpty.map({$0[0..<18]}).bind(to: accountField.rx.text).disposed(by: rx.disposeBag)
        passwordField.rx.text.orEmpty.map({$0[0..<18]}).bind(to: passwordField.rx.text).disposed(by: rx.disposeBag)
        
        let input = RegisterViewModel.Input(account: accountField.asDriver(), password: passwordField.asDriver())
        let output = viewModel.transform(input: input)
        
        output.registerEnable.drive(onNext: { [weak self] in
            self?.registerButton.isEnabled = $0
            self?.registerButton.alpha = $0 ? 1:0.75
        }).disposed(by: rx.disposeBag)
        
        registerButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.registerTapped()
        }).disposed(by: rx.disposeBag)
    }
    
    func registerTapped() {
        
        guard let account = accountField.text,
            let password = passwordField.text else { return }
        
        SVProgressHUD.show()
        viewModel.registerUser(account: account, password: password).subscribe(onNext: { t in
            SVProgressHUD.showSuccess(withStatus: "注册成功")
            UserDefaults.standard.set(t.accessToken, forKey: Key.User.token)
        }, onError: { e in
            if let e = e as? ResultError {
                SVProgressHUD.showError(withStatus: "\(e.message ?? "")")
            }
        }, onCompleted: {
            print("请求结束。")
        }).disposed(by: rx.disposeBag)
        
        
    }
    
}
