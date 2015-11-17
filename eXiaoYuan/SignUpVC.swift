//
//  SignUpVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/6.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class SignUpVC: UIViewController {

    var httpReq = HTTP.sharedInstance
    
    @IBOutlet var courseName: UILabel!
    @IBOutlet var school: UILabel!
    @IBOutlet var usrName: UITextField!
    @IBOutlet var usrTel: UITextField!
    
    var courseInfo = CourseInfo()
    
    
    func addPermissionUsr(){
        var loginVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            
        })
    }
    
    
    @IBAction func signUpBtnClk(sender: UIButton) {
        if checkUsrInfoIsOK(){
            //只有注册的用户才能进行评论,或注册
            if usrInfo.usr.isEmpty {
                if loginStatusInfo.isLogin {
                    
                    //就行报名请求
                    //httpReq.signUp(,courseInfo.name, userid: usrName.text, tel: usrTel.text, cid: courseInfo.c_scid, notificationName: "SignUpVC")
                    httpReq.signUp(usrName.text, schoolname: courseInfo.name, userid: loginStatusInfo.keyid, tel: usrTel.text, cid: courseInfo.c_scid, notificationName: "SignUpVC")
                    
                }else{//未登录会进行登录或注册
                    addPermissionUsr()
                }
                
            }
        }else{
            var alart = UIAlertView(title: "提示", message: "输入有误", delegate: nil, cancelButtonTitle: "重新输入")
            alart.show()
        }
        
        
    }
    
    /**
    检测用户输入信息格式
    */
    func checkUsrInfoIsOK()->Bool{

        if usrTel.text.maximumLengthOfBytesUsingEncoding( NSUTF8StringEncoding) != 33 {
            NSLog("电话号码有误")
            return false
        }
        if usrName.text.maximumLengthOfBytesUsingEncoding( NSUTF8StringEncoding) < 6 {
            NSLog("名字长度不够")
            return false
        }
        return true
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        school.layer.masksToBounds = true
        school.layer.borderWidth = 1
        school.layer.cornerRadius = 4
        school.layer.borderColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1 ).CGColor
        
        courseName.layer.masksToBounds = true
        courseName.layer.borderWidth = 1
        courseName.layer.cornerRadius = 4
        courseName.layer.borderColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1 ).CGColor

        school.text = "   " + courseInfo.name
        courseName.text = "   " + courseInfo.c_name
        
        
        //获取报名情况
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("signUpVCProcess:"), name: "SignUpVC", object: nil)
    }
    
    
    func signUpVCProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("dataTemp = \(dataTemp)")
            
            let data = dataTemp["data"]
            
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到新闻数据数据")
                var alart = UIAlertView(title: "恭喜你", message: "报名成功", delegate: nil, cancelButtonTitle: "确定")
                alart.show()
            }else if "301" == dataTemp["result"].stringValue{
                var alart = UIAlertView(title: "提示", message: "已参加过报名", delegate: nil, cancelButtonTitle: "确定")
                alart.show()
            
            }else{
                var alart = UIAlertView(title: "提示", message: "报名失败", delegate: nil, cancelButtonTitle: "确定")
                alart.show()
            }
        }
    }
    
    //取消通知订阅
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
