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
        
        let sectionOne = TableSectionItem<TapItem>(header: "RxSwift", items: [
            TapItem(title: "点击事件", closure: { [weak self] in
                self?.pushController(TapController.self)
            }),
            TapItem(title: "登录注册", closure: { [weak self] in
                self?.pushController(RegisterController.self)
            }),
            TapItem(title: "数据列表", closure: { [weak self] in
                self?.push(controller: JobController())
            }),
            TapItem(title: "App Clip", closure: { [weak self] in
                self?.push(controller: ClipController())
            })
        ])
        
        Observable.just([sectionOne]).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        Observable
            .zip(tableView.rx.modelSelected(TapItem.self),tableView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (item,indexPath) in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                print("subscribe Item:\(item) index:\(indexPath)\n")
                item.closure?()
                
            }).disposed(by: rx.disposeBag)
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<TableSectionItem<TapItem>>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusable(class: UITableViewCell.self)
            cell.textLabel?.text = "\(indexPath.row + 1). \(item.title)"
            return cell
            
        }, titleForHeaderInSection: { (dataSource, section) -> String? in
            return dataSource[section].header
        })
    
    func pushController<T: UIViewController>(_ controller: T.Type) {
        push(controller: UIStoryboard.load(controller: T.self))
    }
}


