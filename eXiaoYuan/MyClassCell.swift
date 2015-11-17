//
//  MyClassCell.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/10.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit

class MyClassCell: UITableViewCell {

    
    @IBOutlet var className: UILabel!
    @IBOutlet var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
