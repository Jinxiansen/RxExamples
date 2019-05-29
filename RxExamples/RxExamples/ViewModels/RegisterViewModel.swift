//
//  RegisterViewModel.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import Validator
import ObjectMapper
import Moya_ObjectMapper

struct ValidatorError: Error {
    
    public let message: String
    
    public init(message m: String) {
        message = m
    }
}

struct UserValidate {
    
}

class RegisterViewModel {
    
    let accountValidated: Driver<Bool>
    let passwordValidated: Driver<Bool>
    
    let registerEnable: Driver<Bool>
 
    init(input: (account: Driver<String>, password: Driver<String>,registerTap: Signal<Void>)) {

        // 账号验证
        accountValidated = input.account.map{
            let valid = ValidationRuleLength(min: 8, max: 18, lengthType: .utf8, error: ValidatorError(message: "无效账号"))
            return $0.validate(rule: valid).isValid
        }
        
        // 密码验证
        passwordValidated = input.password.map{
            let valid = ValidationRuleLength(min: 6, max: 18, error: ValidatorError(message: "密码无效"))
            return $0.validate(rule: valid).isValid
        }
        
       registerEnable = Driver.combineLatest(accountValidated, passwordValidated) {
            $0 && $1
        }.distinctUntilChanged() // 丢弃重复值
    }
    
    func registerUser(account: String,password: String) -> Observable<Token> {
        return UserProvider.requestData(.register(account: account, password: password)).mapObject(Token.self)
    }

}
