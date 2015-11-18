//
//  NewsClassModel.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/3.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import Foundation





//用户登录全局变量
var usrInfo = UsrInfo()





/**
*  用户报名课程
*/
struct UsrClass {
    
    var code = ""
    var courseid = ""
    var coursename = ""
    var creattime = ""
    var keyid = ""
    var name = ""
    var schoolname = ""
    var tcid = ""
    var tel = ""
    var userid = ""
    
    

}



/**
*  新闻分类
*/


struct NewsClassModel {
    var creattime = ""
    var keyid = ""
    var name = ""
}

/**
*  新闻字段
*/
struct NewsCell {
    var title = ""
    var content = ""
    var sort = ""
    var isrecommend = ""
    var keyid = ""
    var creattime = ""
    var ncid = ""
    var icon = "" //图片
}


struct UsrInfo {
    var usr = ""
    var pwd = ""
}



/**
*  学校信息
*/
struct School {
    var name = ""
    var keyid = ""
    var schoolid = ""
    var creattime = ""
}


/**
*  用户注册时需要的信息
*/
struct RegistInfo {
    var schoolID = ""
    var usr = ""
    var pwd = ""
    
}





struct LoginStatusInfo {
    var address = "";
    var classid = ""
    var createtime = ""
    var display = ""
    var integral = ""
    var keyid = ""
    var pwd = ""
    var remark = ""
    var s_name = ""
    var schoolid = ""
    var sex = ""
    var signintime = ""
    var status = ""
    var tel = ""
    var userid = ""
    var username = ""

    
    
    //自定义
    var isLogin = false
}





/**
*  评论信息，包含二级评论 
*/
struct Comment {
    var newsid = ""
    var isread = ""
    var pbname = ""
    var content = ""
    var keyid = ""
    var fid = ""
    var creattime = ""
    var publishid = ""
    
    var replymsgdata = ""
    var subComment:[Comment] = [Comment]()
}




struct CommentHeader {
    var author = ""
    var time = ""
    var content = ""
}









