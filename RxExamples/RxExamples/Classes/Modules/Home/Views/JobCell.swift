//
//  JobCell.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var item: JobItem? {
        didSet {
            guard let item = item else { return }
            
            titleLabel.text = item.title
            subTitleLabel.text = item.more
            tagLabel.text = item.publisher
            expLabel.text = item.exp

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
