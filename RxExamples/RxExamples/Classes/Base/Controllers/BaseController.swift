//
//  BaseController.swift
//  RxExamples
//
//  Created by jin on 2019/5/28.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BaseController: UIViewController {

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

        logDebug("进入：\(self.nameOfClass)")

        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

//        if let count = navigationController?.viewControllers.count, count > 1 {
//            addBackItem()
//        }

    }

    //语言改变后回调，子类实现更新对应文案
    @objc public func languageDidChange() {}

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func headerRefresh() -> Observable<Void> {
        let refresh = Observable.of(Observable.just(()), headerRefreshTrigger).merge()
        return refresh
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        logDebug("已释放：\(String(describing: Mirror(reflecting: self).subjectType))\n")
    }

}

extension BaseController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let count = self.navigationController?.viewControllers.count else { return false }
        return count > 1 ? true:false
    }
}


extension BaseController: DZNEmptyDataSetSource {

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

extension BaseController: DZNEmptyDataSetDelegate {

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
