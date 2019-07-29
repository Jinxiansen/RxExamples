//
//  UIViewController+Rx.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//


import Foundation
import KafkaRefresh

extension Reactive where Base: KafkaRefreshControl {

    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            if active {
//                refreshControl.beginRefreshing() // 打开会多次调用刷新
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
