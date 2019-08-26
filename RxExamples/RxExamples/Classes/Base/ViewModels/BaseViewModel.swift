//
//  BaseViewModel.swift
//  RxExamples
//
//  Created by jinxiansen on 2019/6/17.
//  Copyright © 2019 晋先森. All rights reserved.
//

import RxSwift
import RxCocoa
import ObjectMapper

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class BaseViewModel: NSObject {

    let error = ErrorTracker()
    let parseError = PublishSubject<ResultError>()

    let loading = ActivityIndicator() //
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()

    let disposeBag = DisposeBag()
    var page = 1

    override init() {
        super.init()

        error.asObservable().map { error -> ResultError? in
            guard let errResponse = error as? ResultError else { return nil }
            return errResponse
            }.filterNil().bind(to: parseError).disposed(by: rx.disposeBag)

        error.asDriver().drive(onNext: { [weak self] error in
            guard let self = self else { return }
            logError(" \(type(of: self).nameOfClass) Response Failed：\(error)")
        }).disposed(by: rx.disposeBag)
    }

    deinit {
        logDebug("已释放：\(String(describing: Mirror(reflecting: self).subjectType))\n")
    }
}
