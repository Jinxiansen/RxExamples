//
//  Observable+Ext.swift
//  AelfApp
//
//  Created by 晋先森 on 2019/6/12.
//  Copyright © 2019 legenddigital. All rights reserved.
//

import Foundation

protocol OptionalType {
    associatedtype Wrapped

    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? {
        return self
    }
}

extension Observable where Element: OptionalType {
    func filterNil() -> Observable<Element.Wrapped> {
        return flatMap { (element) -> Observable<Element.Wrapped> in
            if let value = element.value {
                return .just(value)
            } else {
                return .empty()
            }
        }
    }

    func filterNilKeepOptional() -> Observable<Element> {
        return self.filter { (element) -> Bool in
            return element.value != nil
        }
    }

    func replaceNil(with nilValue: Element.Wrapped) -> Observable<Element.Wrapped> {
        return flatMap { (element) -> Observable<Element.Wrapped> in
            if let value = element.value {
                return .just(value)
            } else {
                return .just(nilValue)
            }
        }
    }
}


extension ObservableType {

    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            assertionFailure("Error \(error)")
            return Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
