//
//  BaseApi.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation

struct BaseApi {
    
    static var BaseURL: URL {
        
        #if DEBUG
        return try! "http://api.jinxiansen.com/".asURL()
        #else
        return try! "http://api.jinxiansen.com/".asURL() //
        #endif
    }
    
    static var headers: [String : String]? {
        return ["Content-type":"application/x-www-form-urlencoded; charset=utf-8"]
    }
    
    static let networkActivityPlugin = NetworkActivityPlugin { (change,_)  -> () in
        switch(change){
        case .ended:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        case .began:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }
}

extension BaseApi {
    
    static func jsonResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data //fallback to original data if it cant be serialized
        }
    }
    
}

