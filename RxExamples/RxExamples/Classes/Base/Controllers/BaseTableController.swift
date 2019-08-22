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

    let isLoading = BehaviorRelay(value: false)

    let headerRefreshTrigger = PublishSubject<Void>()
    let footerRefreshTrigger = PublishSubject<Void>()

    let emptyDataSetButtonTap = PublishSubject<Void>()
    fileprivate var emptyDataSetTitle = "" // 暂时用不到

    var emptyDataSetButtonTitle = "Retry"
    var emptyDataSetDescription = BehaviorRelay<String>(value: "No Data")
    var emptyDataSetImage = UIImage(named: "information")

    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    var emptyDataButonHidden = BehaviorRelay<Bool>(value: true)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        bindRefresh()
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

    func headerRefresh() -> Observable<Void> {
        let refresh = Observable.of(Observable.just(()), headerRefreshTrigger).merge()
        return refresh
    }

    private func bindRefresh() {

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
 
extension BaseTableController: DZNEmptyDataSetSource {

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        let inset = tableView.contentInset
        return inset.top == 0 ? -64:0
    }

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetDescription.value)
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }

    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor.value
    }

    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }

}

extension BaseTableController: DZNEmptyDataSetDelegate {

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        emptyDataSetButtonTap.onNext(())
    }

    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let title = emptyDataButonHidden.value == true ? "":emptyDataSetButtonTitle
        return NSAttributedString(string: title,
                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.master])
    }


}
