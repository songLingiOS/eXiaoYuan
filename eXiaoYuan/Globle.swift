//
//  Globle.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/5.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import Foundation

/// 全局变量，登录状态显示
var loginStatusInfo = LoginStatusInfo()


/**
设置tableView背景图片

- parameter tab: tab description
- parameter img: img description
*/
func setTableViewBackImg(tableView:UITableView,img:String,frame:CGRect){
    let backImg =  UIImageView()
    backImg.frame = frame
    backImg.alpha = 0.3
    backImg.image = UIImage(named: img)
    tableView.backgroundView = backImg
}
