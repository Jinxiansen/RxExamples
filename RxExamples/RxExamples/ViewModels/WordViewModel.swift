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

class WordViewModel: NSObject {
    
    let models = Variable<[Word]>([])
    var page: Int = 1
    
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
        
        //刷新状态
        let refreshStatus = Variable<RefreshStatus>(.none)
        
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
            
            self.page = isNext ? 1: self.page + 1 // 
            WordProvider.requestData(.word(text: input.searchText,page: self.page)).mapObjects(Word.self).subscribe(onNext: { (s) in
                self.models.value = isNext ? s : (self.models.value + s)
                print("总数据：\(self.models.value.count)条\n")
            }, onError: { e in
                print("获取词语出错: \(e)\n")
            }, onCompleted: {
                out.refreshStatus.value = isNext ? .endHeaderRefresh : .endFooterRefresh
                print("请求完毕,当前页码：\(self.page)")
            }).disposed(by:self.rx.disposeBag)
            
        }).disposed(by: self.rx.disposeBag)
        
        return out
    }
}
