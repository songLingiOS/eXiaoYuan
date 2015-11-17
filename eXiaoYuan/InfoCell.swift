//
//  infoCell.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/3.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    
    @IBOutlet var img: UIImageView!
    @IBOutlet var theTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var cell = NewsCell()
    var setCell:NewsCell{
        set{
            theTitle.text = newValue.title
            img.sd_setImageWithURL(NSURL(string: newValue.icon))
            
            img.layer.masksToBounds = true
            img.layer.borderWidth = 1
            img.layer.cornerRadius = 10
            img.layer.borderColor = UIColor.whiteColor().CGColor//UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1 ).CGColor
        }
        get{
            return cell
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
