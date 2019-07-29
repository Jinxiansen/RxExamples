//
//  BaseTableController.swift
//  RxExamples
//
//  Created by 晋先森 on 2019/6/17.
//  Copyright © 2019 legenddigital. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import KafkaRefresh

class BaseTableController: BaseController {

    let isHeaderLoading = BehaviorRelay(value: false)
    let isFooterLoading = BehaviorRelay(value: false)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        rxBindRefresh()
    }

    lazy var tableView: BaseTableView = {
        let view = BaseTableView(frame: self.view.bounds, style: .plain)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            view.emptyDataSetSource = self
            view.emptyDataSetDelegate = self
            view.reloadEmptyDataSet()
        })
        return view
    }()
 
    func rxBindRefresh() {

        // https://github.com/OpenFeyn/KafkaRefresh/blob/master/CREADME.md
        tableView.bindHeadRefreshHandler({ [weak self] in
            self?.headerRefreshTrigger.onNext(())
        }, themeColor: UIColor.master, refreshStyle: .replicatorCircle)

        tableView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            self?.footerRefreshTrigger.onNext(())
        })

        tableView.footRefreshControl.autoRefreshOnFoot = true

        isHeaderLoading.bind(to: tableView.headRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
        isFooterLoading.bind(to: tableView.footRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)

        let updateEmptyDataSet = Observable.of(isLoading.mapToVoid(),
                                               emptyDataSetImageTintColor.mapToVoid(),
                                               emptyDataButonHidden.mapToVoid(),
                                               emptyDataSetDescription.mapToVoid()).merge()
        updateEmptyDataSet.subscribe(onNext: { [weak self] () in
            self?.tableView.reloadEmptyDataSet()
        }).disposed(by: rx.disposeBag)
    }

}

extension BaseTableController {

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        let inset = tableView.contentInset
        return inset.top == 0 ? -64:0
    }
}
