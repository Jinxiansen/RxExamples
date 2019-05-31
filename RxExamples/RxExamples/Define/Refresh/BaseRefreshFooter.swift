//
//  BaseRefreshFooter.swift
//  RxExamples
//
//  Created by jin on 2019/5/31.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
import MJRefresh

class BaseRefreshFooter: MJRefreshAutoFooter {

    fileprivate let titleLabel = UILabel().then {
        $0.textColor = UIColor.lightGray
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
    }
    
    fileprivate lazy var loading: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .gray)
    }()
    
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                loading.stopAnimating()
                titleLabel.text = "下拉刷新"
            case .noMoreData:
                loading.stopAnimating()
                titleLabel.text = "木有数据了"
            case .refreshing:
                loading.startAnimating()
                titleLabel.text = "加载数据中"
            default:
                break
            }
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    // 在这里做一些初始化配置（比如添加子控件）
    override func prepare() {
        super.prepare()
        
        mj_h = 50
        
        addSubview(titleLabel)
        addSubview(loading)
    }
    
    // 设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        
        titleLabel.frame = self.bounds;
        let size = titleLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 20))
        loading.center = CGPoint(x: (self.frame.size.width + size.width)/2 + 15, y: self.mj_h * 0.5)
    }
    
}
