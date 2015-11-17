//
//  CommentCell.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/5.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    
    
    @IBOutlet var author: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var content: UILabel!
    
    var CommentHeaderPara = CommentHeader()
    var header:CommentHeader{
        set{
            CommentHeaderPara = newValue
            author.text = newValue.author
            time.text = newValue.time
            content.text = newValue.content
        }
        
        get{
            return CommentHeaderPara
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
