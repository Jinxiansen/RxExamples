//
//  WordCell.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }
    
    var word: Word? {
        didSet {
            guard let word = word else { return }
            
            titleLabel.text = word.ci
            subTitleLabel.text = word.explanation
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
