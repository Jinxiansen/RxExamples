//
//  Refreshable.swift
//  RxExamples
//
//  Created by jin on 2019/5/31.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import MJRefresh

enum RefreshStatus {
    case none
    case begingHeaderRefresh
    case endHeaderRefresh
    case begingFooterRefresh
    case endFooterRefresh
    case endAllRefresh
    
    //  - 数据为空的时候隐藏 `mj_footer`，否则显示；
    //  - 然后判断没有更多数据就调用 `endRefreshingWithNoMoreData()`
    //    否则 `endRefreshing()`
    case footerStatus(isHidden: Bool, isNoMoreData: Bool)
    
}

//
protocol Refreshable {
    
    var refreshStatus: BehaviorSubject<RefreshStatus> { get }
    
}


extension Refreshable {
    
    func refreshBind(to scrollView: UIScrollView,header:(()-> Void)? = nil,footer:(() -> Void)? = nil) -> Disposable {
        if header != nil {
            scrollView.mj_header = BaseRefreshHeader(refreshingBlock: {
                scrollView.mj_header.endRefreshing()
                header?()
            })
        }
        
        if footer != nil {
            scrollView.mj_footer = BaseRefreshFooter(refreshingBlock: {
                scrollView.mj_header.endRefreshing()
                footer?()
            })
        }
        
        return refreshStatus.subscribe(onNext: { (status) in
            
            switch status {
            case .none:
                scrollView.mj_footer?.isHidden = true
            case .begingHeaderRefresh:
                scrollView.mj_header?.beginRefreshing()
            case .endHeaderRefresh:
                scrollView.mj_header?.endRefreshing()
            case .begingFooterRefresh: break
            case .endFooterRefresh: break
                
            case .endAllRefresh:
                scrollView.mj_header?.endRefreshing()
                scrollView.mj_footer?.endRefreshing()
                
            case .footerStatus(let isHidden, let isNoMoreData):
                // 根据关联值确定 footer 的状态。
                scrollView.mj_footer?.isHidden = isHidden
                // 处理尾部状态时，如果之前正在刷新头部，则结束刷新，
                // 至此，我们无需写判断结束头部刷新的代码，在这里自动处理。
                scrollView.mj_header?.endRefreshing()
                if isNoMoreData {
                    scrollView.mj_footer?.endRefreshingWithNoMoreData()
                }else {
                    scrollView.mj_footer?.endRefreshing()
                }
            }
        })
        
    }
}
