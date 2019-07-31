//
//  HomeController.swift
//  RxExamples
//
//  Created by jin on 2019/5/27.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit
import Hero

class HomeController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }

    
    func configureTableView() {
        
        tableView.registerCell(class: UITableViewCell.self)
        tableView.tableFooterView = UIView()
        
        let sec1 = SectionType<TableItem>(header: "RxSwift", items: [
            TableItem(title: "点击事件", type: RxType.tap),
            TableItem(title: "登录注册", type: RxType.register),
            TableItem(title: "数据列表", type: RxType.word)
            ])
        
        Observable.just([sec1]).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)

        Observable
            .zip(tableView.rx.modelSelected(TableItem.self),tableView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (item,indexPath) in
                
                self?.tableView.deselectRow(at: indexPath, animated: false)
                print("subscribe Item:\(item) index:\(indexPath)\n")
                
                self?.didSelectEvent(item)
                
            }).disposed(by: rx.disposeBag)
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionType<TableItem>>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusable(class: UITableViewCell.self)
            cell.textLabel?.text = "\(indexPath.row + 1). \(item.title)"
            return cell
            
    }, titleForHeaderInSection: { (dataSource, section) -> String? in
        return dataSource[section].header
    })
    
    func didSelectEvent(_ item: TableItem) {
        
        var t = UIViewController.self
        switch item.type {
        case .tap:
            t = TapController.self
            break
        case .register:
            t = RegisterController.self
            break
        case .word:
            push(controller: JobController())
            return // 
        }
        
        push(controller: UIStoryboard.load(controller: t))
    }
}


