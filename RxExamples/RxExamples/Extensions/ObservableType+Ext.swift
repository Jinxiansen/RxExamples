//
//  ObservableType+Result.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import ObjectMapper

extension ObservableType where E == VResult {
    
    func mapObjects<T: Mappable>(_ map: T.Type, context: MapContext? = nil) -> Observable<[T]> {
        return flatMap({
            return Observable.just(try $0.mapObjects(T.self, context: context))
        })
    }
    
    func mapObject<T: Mappable>(_ map: T.Type, context: MapContext? = nil) -> Observable<T> {
        return flatMap({
            return Observable.just(try $0.mapObject(map, context: context))
        })
    }
}
