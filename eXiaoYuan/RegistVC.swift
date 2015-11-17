//
//  RegistVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/4.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class RegistVC: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate{

    let httpReq = HTTP.sharedInstance
    
    @IBAction func dismissBtnClk(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    var schoolArry = [School]()
    
    var registInfo = RegistInfo()
    
    @IBOutlet var school: UITextField!
    @IBOutlet var usr: UITextField!
    @IBOutlet var pwd: UITextField!
    @IBAction func registBtnClk(sender: UIButton) {
        NSLog("注册按钮点击")
        if checkUsrInfoIsOK(){
            registInfo.usr = self.usr.text
            registInfo.pwd = self.pwd.text
            httpReq.usrRegist(registInfo.schoolID, name: registInfo.usr, passwd: registInfo.pwd, notificationName: "usrRegist")
        
        }else{
            var alart = UIAlertView(title: "提示", message: "输入有误", delegate: nil, cancelButtonTitle: "重新输入")
            alart.show()
        }

    }
    
    /**
    检测用户输入信息格式
    */
    func checkUsrInfoIsOK()->Bool{
        if school.text.isEmpty {
            return false
        }
        
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        school.delegate = self
        
        
        //获取学校信息
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("getSchooleInfoProcess:"), name: "getSchooleInfo", object: nil)
        httpReq.getSchooleInfo("getSchooleInfo")
        
        //获取注册结果
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("usrRegistProcess:"), name: "usrRegist", object: nil)

    }

    
    //取消通知订阅
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /**
    获取到学校信息
    
    - parameter sender: sender description
    */
    func getSchooleInfoProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("schoolList = \(dataTemp)")
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到数据")
                var data = dataTemp["data"]
                
                schoolArry = []
                for var i = 0 ; i < data.count; i++ {
                    var temp = data[i]
                    var schoolTemp = School()
                    schoolTemp.name = temp["name"].stringValue
                    schoolTemp.keyid = temp["keyid"].stringValue
                    schoolTemp.schoolid = temp["schoolid"].stringValue
                    schoolTemp.creattime = temp["creattime"].stringValue
                    NSLog("schoolTemp.name:\(schoolTemp.name)")
                    schoolArry.append(schoolTemp)
                }
            }
        }
    }
    
    
    /**
    注册结果显示
    
    - parameter sender: sender description
    */
    func usrRegistProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("registResult = \(dataTemp)")
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到数据")
                var alart = UIAlertView(title: "注册成功", message: "恭喜你，注册成功，请返回登录页面进行登录", delegate: self, cancelButtonTitle: "确定")
                alart.delegate = self
                alart.show()
            }
        }
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if alertView.title == "注册成功" {
            
            alertView.delegate = nil
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
                
            })
        }
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField){ // became first responder
        NSLog("学校选择")
        school.resignFirstResponder()
        var pickerView = UIPickerView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: 60))
        pickerView.backgroundColor = UIColor.redColor()
        self.view.addSubview(pickerView)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }

}

extension RegistVC{
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return schoolArry.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return schoolArry[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NSLog("选择的学校是:\(schoolArry[row].name)")
        school.text = schoolArry[row].name
        
        registInfo.schoolID = schoolArry[row].keyid
        
        pickerView.dataSource = nil
        pickerView.delegate = nil
        pickerView.hidden = true
    }
}
