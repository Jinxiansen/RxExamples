//
//  JobViewModel.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class JobViewModel: BaseViewModel {

}

extension JobViewModel: ViewModelType {

    struct Input {
        let headerRefresh: Observable<Void>
        let footerRefresh: Observable<Void>
    }
    
    struct Output {
        let items = BehaviorRelay<[JobItem]>(value: [])
    }
    
    func transform(input: JobViewModel.Input) -> JobViewModel.Output {
        let output = Output()

        input.headerRefresh.flatMapLatest { _ -> Observable<[JobItem]> in
            self.page = 1
            return self.requestJobs()
                .trackActivity(self.headerLoading)
                .catchErrorJustComplete()
            }.bind(to: output.items).disposed(by: rx.disposeBag)

        input.footerRefresh.flatMapLatest { _ -> Observable<[JobItem]> in
            self.page += 1
            return self.requestJobs().trackActivity(self.footerLoading)
            }.subscribe(onNext: { items in
                output.items.accept(output.items.value + items)
            }).disposed(by: rx.disposeBag)
        
        return output
    }
}


extension JobViewModel {

    func requestJobs() -> Observable<[JobItem]> {
        return jobProvider.requestData(.jobs(page: page))
            .mapObjects(JobItem.self)
            .trackError(error)
            .trackActivity(loading)
    }

}
