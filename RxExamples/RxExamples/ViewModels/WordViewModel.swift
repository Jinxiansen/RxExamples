//
//  WordViewModel.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WordViewModel: Refreshable {
    var refreshStatus = BehaviorSubject<RefreshStatus>(value: .none)
    
    let models = Variable<[Word]>([])
    var page: Int = 1
    
    let bag = DisposeBag()
    
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

extension WordViewModel: ViewModelType {
    
    typealias Input = WordInput
    typealias Output = WordOutput
    
    struct WordInput {
        
        var searchText = ""
    }
    
    struct WordOutput {
        
        // TableView 的 Section 数据
        let sections: Driver<[WordSection]>
        
        // 传入是否加载下一页
        let  isRequestNext = PublishSubject<Bool>()

        init(sections:Driver<[WordSection]>) {
            self.sections = sections
        }
    }
    
    
    func transform(input: WordViewModel.WordInput) -> WordViewModel.WordOutput {
        let sections = models.asObservable().map {
            return [WordSection(items: $0)]
            }.asDriver(onErrorJustReturn: [])
        
        let out = WordOutput(sections: sections)
        out.isRequestNext.subscribe(onNext: { (isNext) in
            
            self.page = isNext ? self.page + 1 : 1 // true = 第一页，false = 下一页
            WordProvider.requestData(.word(text: input.searchText,page: self.page)).mapObjects(Word.self).subscribe(onNext: { (result) in
                self.models.value = isNext ? (self.models.value + result): result
                print("总数据：\(self.models.value.count)条\n")
                self.refreshStatus.onNext(.footerStatus(isHidden: self.models.value.isEmpty, isNoMoreData: result.count == 0))
                
            }, onError: { e in
                print("获取词语出错: \(e)\n")
                self.refreshStatus.onNext(.endAllRefresh)
            }, onCompleted: {
                print("请求完毕,当前页码：\(self.page)")
            }).disposed(by:self.bag)
            
        }).disposed(by: bag)
        
        return out
    }
}
