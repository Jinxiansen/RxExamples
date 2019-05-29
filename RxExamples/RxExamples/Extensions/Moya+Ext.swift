//
//  Moya+Ext.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

typealias ResultCompletion = (_ result:VResult)->()

extension MoyaProvider {
    
    private func requestData(_ target: Target,
                      completion: ResultCompletion?) -> Cancellable {

        return self.request(target, completion: { (result) in
            switch result {
            case .success(let value):
                completion?(value.toResult())
            case .failure(let err):
                print("\n请求出错：\(err)\n")
                completion?(VResult.dataError())
            }
        })
    }

    func requestData(_ target: Target) -> Observable<VResult> {

        return Observable.create { [weak self] observer in
            let cancellableToken = self?.requestData(target) { result in
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    

    // ---
    public class func JSONEndpointMapping(_ target: Target) -> Endpoint {
        
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        return Endpoint(
            url: url,
            sampleResponseClosure: {
                .networkResponse(200, target.sampleData)
        },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}
