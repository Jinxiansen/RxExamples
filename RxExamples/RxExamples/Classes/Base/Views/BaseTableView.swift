//
//  TableView.swift
//
//  Created by 晋先森 on 16/12/19.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit
import ViewAnimator

let animations = [AnimationType.from(direction: .bottom, offset: 20.0),AnimationType.zoom(scale: 0.8)]

class BaseTableView: UITableView {

    init () {
        super.init(frame: CGRect(), style: .grouped)
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        backgroundColor = .clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorColor = .clear
        tableFooterView = UIView()
    }

    override func reloadData() {
        super.reloadData()
        
        if visibleCells.isEmpty { return }
        _ = onceCode
    }

    lazy var onceCode: Void = {
        UIView.animate(views: self.visibleCells, animations: animations, completion: {
        })
        logInfo("Run once !")
    }()

}
