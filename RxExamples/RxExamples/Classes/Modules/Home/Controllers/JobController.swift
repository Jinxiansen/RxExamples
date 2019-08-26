//
//  JobController.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit

class JobController: BaseTableController {

    let viewModel = JobViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Job"

        tableView.registerCell(nib: JobCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.pullRefresh(animted: true)
        }
        
    }

    override func bindViewModel() {
        super.bindViewModel()

        let input = JobViewModel.Input(headerRefresh: headerRefresh(), footerRefresh: footerRefreshTrigger)

        let output = viewModel.transform(input: input)

        emptyDataSetButtonTap.subscribe(onNext: { [weak self] _ in
            self?.headerRefreshTrigger.onNext(())
        }).disposed(by: rx.disposeBag)

        output.items.bind(to: tableView.rx.items(cellIdentifier: JobCell.nameOfClass,
                                                 cellType: JobCell.self)) { (_, element, cell) in
                                                    cell.item = element
            }.disposed(by: rx.disposeBag)

        Observable.zip(tableView.rx.modelSelected(JobItem.self),tableView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (item,indexPath) in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            SVProgressHUD.showInfo(withStatus: item.publisher ?? "")
        }).disposed(by: rx.disposeBag)

    }
}
