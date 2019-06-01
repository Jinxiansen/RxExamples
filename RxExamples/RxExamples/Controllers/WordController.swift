//
//  WordController.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit
import MJRefresh

class WordController: BaseController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "中国"
        view.addSubview(tableView)
        bindViewEvent()
        
    }
 
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.groupTableViewBackground
        $0.registerCell(nib: WordCell.self)
        $0.tableFooterView = UIView()
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 80
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<WordSection>(configureCell: { (section, tableView, indexPath, word) -> UITableViewCell in
        let cell = tableView.dequeueReusable(class: WordCell.self)
        cell.word = word
        return cell
    })
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.frame = self.view.bounds
    }

    func bindViewEvent() {
        
        let viewModel = WordViewModel()
        let input = WordViewModel.Input(searchText: title ?? "")
        let output = viewModel.transform(input: input)
        
        output.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        // 添加下拉刷新
        viewModel.refreshBind(to: tableView, header: {
            output.isRequestNext.onNext(false) // 头部刷新
        }) {
            output.isRequestNext.onNext(true) // 下一页
        }.disposed(by: rx.disposeBag)
        
        Observable.zip(tableView.rx.itemSelected,tableView.rx.modelSelected(Word.self)).subscribe(onNext: { [weak self] (index,word) in
            self?.tableView.deselectRow(at: index, animated: false)

            SVProgressHUD.showInfo(withStatus: word.ci)
        }).disposed(by: rx.disposeBag)
        
        output.isRequestNext.onNext(false) // 触发刷新第一页; true = 第一页，false = 下一页
    
        
    }
}
