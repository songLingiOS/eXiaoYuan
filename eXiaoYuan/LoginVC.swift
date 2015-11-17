//
//  LoginVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/5.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class LoginVC: UIViewController {

    var httpReq = HTTP.sharedInstance
    
    @IBAction func loginBtnClk(sender: UIButton) {
        NSLog("登录")
        if checkUsrInfoIsOK(){
            httpReq.login(pwd.text, username: usr.text, notificationName: "LoginVC")
            
        }else{
            var alart = UIAlertView(title: "提示", message: "输入有误", delegate: nil, cancelButtonTitle: "重新输入")
            alart.show()
        }
        
    }
    
    /**
    检测用户输入信息格式
    */
    func checkUsrInfoIsOK()->Bool{
        
        if usr.text.maximumLengthOfBytesUsingEncoding( NSUTF8StringEncoding) != 33 {
            NSLog("usr.text.length = \(usr.text.maximumLengthOfBytesUsingEncoding( NSUTF8StringEncoding)) ")
            return false
        }
        if pwd.text.maximumLengthOfBytesUsingEncoding( NSUTF8StringEncoding) < 18 {
            NSLog("pwd.text.length = \(usr.text.maximumLengthOfBytesUsingEncoding( NSUTF8StringEncoding)) ")
            return false
        }
        return true
    }

    
    @IBOutlet var protal: UIImageView!
    @IBOutlet var usr: UITextField!
    @IBOutlet var pwd: UITextField!
    
    func setProtalView(){
        protal.layer.masksToBounds = true
        protal.layer.borderWidth = 1
        protal.layer.cornerRadius = 50
        protal.layer.borderColor = UIColor.clearColor().CGColor//UIColor(red: 38/255, green: 168/255, blue: 231/255, alpha: 1 ).CGColor
    }
    
    @IBAction func dismissBtnClk(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setProtalView()
        //获取登录结果
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("loginVCProcess:"), name: "LoginVC", object: nil)
        
        
        /// 用户名记忆功能
        if let name:String = NSUserDefaults.standardUserDefaults().objectForKey("eXiaoyuan_usr") as? String{
            usr.text = name//NSUserDefaults.standardUserDefaults().objectForKey("eXiaoyuan_usr") as! String
            NSLog("usr = \(name)")
        }
        /// 密码记忆功能
        if let secret:String = NSUserDefaults.standardUserDefaults().objectForKey("eXiaoyuan_pwd") as? String{
            pwd.text = secret//NSUserDefaults.standardUserDefaults().objectForKey("eXiaoyuan_pwd") as! String
            NSLog("pwd = \(secret)")
        }
        
        
    }

    /**
    登录结果
    
    - parameter sender: sender description
    */
    func loginVCProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("loginResult = \(dataTemp)")
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到数据")
                var data = dataTemp["data"]
                var infoTemp = data[0]
                
                var temp = LoginStatusInfo()
                temp.address = infoTemp["address"].stringValue
                temp.classid = infoTemp["classid"].stringValue
                temp.createtime = infoTemp["createtime"].stringValue
                temp.display = infoTemp["display"].stringValue
                temp.integral = infoTemp["integral"].stringValue
                temp.keyid = infoTemp["keyid"].stringValue
                temp.pwd = infoTemp["pwd"].stringValue
                temp.remark = infoTemp["remark"].stringValue
                temp.schoolid = infoTemp["schoolid"].stringValue
                temp.sex = infoTemp["sex"].stringValue
                temp.signintime = infoTemp["signintime"].stringValue
                temp.status = infoTemp["status"].stringValue
                temp.tel = infoTemp["tel"].stringValue
                temp.userid = infoTemp["userid"].stringValue
                temp.username = infoTemp["username"].stringValue
                
                
                
                loginStatusInfo = temp
                
                //保存用户名和密码
                NSUserDefaults.standardUserDefaults().setObject(loginStatusInfo.userid, forKey: "eXiaoyuan_usr")
                NSUserDefaults.standardUserDefaults().setObject(loginStatusInfo.pwd, forKey: "eXiaoyuan_pwd")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                
                loginStatusInfo.isLogin = true

                
                
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
