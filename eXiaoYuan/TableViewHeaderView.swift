//
//  TableViewHeaderView.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/5.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit

class TableViewHeaderView: UIView {

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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
