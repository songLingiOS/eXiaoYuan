//
//  HTTP.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/10/30.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//




import Foundation
import Alamofire
class HTTP{
    //单例模式
    static let sharedInstance = HTTP()
    
    private init() {}
    
    let serverIP = "http://m.yaode100.com:88/Esch"
    
    
    

    /**
    8.【查询用户报名】信息
    
    - parameter userid:           userid description
    - parameter notificationName: notificationName description
    */
    func signUpClassInfo(userid:String,notificationName:String){
        if serverIsAvalaible() == false{
            return
        }
        let para = ["format":"normal","userid":userid]
        let url = serverIP + "/registration/getreginfo?"
        requestServers(url, para: para, notificationName: notificationName)
    }
    
    
    
    /**
    7.【报名】添加
    */
    func signUp(name:String,schoolname:String,userid:String,tel:String,cid:String,notificationName:String){
        if serverIsAvalaible() == false{
            return
        }
        let para = ["format":"normal","userid":userid,"name":name,"tel":tel,"cid":cid,"schoolname":schoolname]
        let url = serverIP + "/registration/addregistration?"
        requestServers(url, para: para, notificationName: notificationName)
        
    }
    

    /**
    获取大类别下面的小类别（根据大类别名称）
    
    - parameter courseName:       courseName description
    - parameter notificationName: notificationName description
    */
    func getClassSubName(courseName:String,notificationName:String){
        if serverIsAvalaible() == false{
            return
        }
        let para = ["format":"normal","cname":courseName]
        let url = serverIP + "/course/getonechss?"
        requestServers(url, para: para, notificationName: notificationName)
    }
    
    /**
    4.获取【所有课程名称】信息列表
    */
    func getClassName(notificationName:String){
        if serverIsAvalaible() == false{
            return
        }
        let para = ["format":"normal","type":"all"]
        let url = serverIP + "/course/qacname?"
        requestServers(url, para: para, notificationName: notificationName)
    }
    
    /**
    13.获取【某新闻下所有的留言回复】
    
    - parameter newsid:           newsid description
    - parameter startNo:          startNo description
    - parameter endNo:            endNo description
    - parameter notificationName: notificationName description
    */
    func newsComment(newsid:String,startNo:String,endNo:String,notificationName:String){
        if serverIsAvalaible() == false{
            return
        }
        let para = ["format":"normal","newsid":newsid,"s_row":startNo,"e_row":endNo]
        let url = serverIP + "/leavemsg/getanlm?"
        requestServers(url, para: para, notificationName: notificationName)
    }
    
    

    
    /**
    1.用户【登录】
    
    - parameter pwd:              pwd description
    - parameter username:         username description
    - parameter notificationName: notificationName description
    */
    func login(pwd:String,username:String,notificationName:String){
        if serverIsAvalaible() == false{
            return
        }
        let para = ["format":"normal","username":username,"pwd":pwd]
        let url = serverIP + "/user/userlogin?"
        requestServers(url, para: para, notificationName: notificationName)
        
    }
    
    
    
    

    /**
    3.获取【学校】信息列表
    
    - parameter notificationName: notificationName description
    */
    func getSchooleInfo(notificationName:String){
        if serverIsAvalaible() == false{
            return
        }
        let para = ["format":"normal","type":"all"]
        let url = serverIP + "/sch/qasch?"
        requestServers(url, para: para, notificationName: notificationName)
    }
    
    /**
    用户注册
    
    - parameter schoolID: 学校ID
    - parameter name:     用户名称
    - parameter passwd:   用户密码
    */
    func usrRegist(schoolID:String,name:String,passwd:String,notificationName:String){
        //先检测网络状态
        if serverIsAvalaible() == false{
            return
        }
        
        //
        
        let para = ["format":"normal","schid":schoolID,"username":name,"pwd":passwd]
        let url = serverIP + "/user/userreg?"
        requestServers(url, para: para, notificationName: notificationName)
    }
    

    /**
    9.获取【所有新闻类别列表】信息
    
    news/qanewst
    
    format=normal&type=all
    
    return 成功100 失败101 解析数据data 无数据 10011
    ----------------------------------------------------------------------
    - parameter notificationName: notificationName description
    */
    func newsClass(notificationName:String){
        //先检测网络状态
        if serverIsAvalaible() == false{
            return
        }
        
        let para = ["format":"normal","type":"all"]
        let url = serverIP + "/news/qanewst?"
        requestServers(url, para: para, notificationName: notificationName)


        
    }
    
    

    /**
    10.获取【某新闻类别下的所有新闻】
    
    - parameter typeid:           typeid description
    - parameter startRow:         startRow description
    - parameter toRow:            toRow description
    - parameter notificationName: notificationName description
    */
    func getNews(typeid:String,startRow:String,toRow:String,notificationName:String){
        //先检测网络状态
        if serverIsAvalaible() == false{
            return
        }
        
        let para = ["format":"normal","typeid":typeid,"s_row":startRow,"e_row":toRow]
        let url = serverIP + "/news/qancot?"
        requestServers(url, para: para, notificationName: notificationName)

    }
    
    
    /***************************************************************************************/
    /***************************************************************************************/
    /***************************************************************************************/
    /***************************************************************************************/
    /***************************************************************************************/
    /***************************************************************************************/
    
    
    /**
    网络请求
    
    - parameter url:       网络请求路径
    - parameter para:      参数
    - parameter notifyOBJ: 网络请求回调
    */
    private func requestServers(url:String,para:[String:String],notificationName:String){
        SVProgressHUD.dismiss()
        SVProgressHUD.showWithStatus("数据请求中...")
        
        Alamofire.request(.GET, url, parameters:para ).responseJSON(options: nil, completionHandler: { (Request,Response, data, error) -> Void in
            NSLog("\(Request)")
            NSLog("\(data)")
            
            if error != nil {
                
            }
            SVProgressHUD.dismiss()
            NSNotificationCenter.defaultCenter().postNotificationName(notificationName, object: data, userInfo: nil)
        })
        
    }
    
    /**
    网络连接检测
    
    - returns: 网络可以使用返回为true，否则为false
    */
    func serverIsAvalaible()->Bool{
        let reach = Reachability(hostname: "www.baidu.com")
        var netState :NetworkStatus = reach!.currentReachabilityStatus()
        var state = false
        switch(netState){
        case NetworkStatus.NotReachable :
            var alart = UIAlertView(title: "提示", message: "无可用的网络!!!", delegate: nil, cancelButtonTitle: "确定")
            alart.show()
            state = false
            println("NotReachable")
        case NetworkStatus.ReachableViaWiFi:
            println("ReachableViaWiFi")
            state = true
        default:
            state = true
            println("ReachableViaWWAN")
            break
        }
        return state
    }
    
}
