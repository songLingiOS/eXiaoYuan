//
//  Profile.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/9.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class Profile: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    var httpReq = HTTP.sharedInstance
    
    func addPermissionUsr(){
        var loginVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            
        })
    }
    
    @IBAction func loginBtnClk(sender: UIButton) {
        NSLog("点击登陆")
        addPermissionUsr()
        
    }
    
    
    /**
    Navigation外观
    */
    func setNavigationBar(){
  
        //1、返回标签
        let item = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = item
        //2、颜色（UINavigationBar）
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        //设置背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 43/255, green: 184/255, blue: 170/255, alpha: 1.0)
        //富文本设置颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //隐藏毛玻璃效果
        //self.navigationController?.navigationBar.translucent = false
        
    }
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var protal: UIImageView!
    @IBOutlet var usr: UILabel!
    @IBOutlet var tableview: UITableView!
    
    //我的报名
    var myClass = [UsrClass]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        protal.layer.masksToBounds = true
        protal.layer.borderWidth = 1
        protal.layer.cornerRadius = 25
        protal.layer.borderColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1 ).CGColor
        
        
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.borderColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1 ).CGColor

        
        
        //注册cell(无数据时调用)
        tableview.registerNib(UINib(nibName: "NodateCell", bundle: nil), forCellReuseIdentifier: "NodateCell")
        //注册cell
        tableview.registerNib(UINib(nibName: "MyClassCell", bundle: nil), forCellReuseIdentifier: "MyClassCell")
        
        
        tableview.delegate = self
        tableview.dataSource = self
        
        setNavigationBar()
        
        
    }

    override func viewWillAppear(animated: Bool) {
        if loginStatusInfo.isLogin {
            loginBtn.hidden = true
            usr.hidden = false
            usr.text = loginStatusInfo.userid
            
            //获取用户报名信息
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("signUpClassInfoProcess:"), name: "signUpClassInfo", object: nil)
            httpReq.signUpClassInfo(loginStatusInfo.keyid, notificationName: "signUpClassInfo")
            
            
            
        }else{
            loginBtn.hidden = false
            usr.hidden = true
        }
        
        
        self.navigationController?.navigationBar.hidden = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    func signUpClassInfoProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("dataTemp = \(dataTemp)")
            
            let data = dataTemp["data"]
            
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到报名信息")
                let data = dataTemp["data"]
                var temp = UsrClass()
                myClass = []
                
                for var i = 0 ; i < data.count ; i++ {
                    var d = data[i]
                    temp.tel = d["tel"].stringValue
                    temp.userid = d["userid"].stringValue
                    temp.code = d["code"].stringValue
                    temp.schoolname = d["schoolname"].stringValue
                    temp.courseid = d["courseid"].stringValue
                    temp.keyid = d["keyid"].stringValue
                    temp.creattime = d["creattime"].stringValue
                    temp.coursename = d["coursename"].stringValue
                    temp.name = d["name"].stringValue
                    temp.tcid = d["tcid"].stringValue
                    
                   
                    myClass.append(temp)  
                }
                
                tableview.reloadData()
                
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
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if loginStatusInfo.isLogin {
            myClass.count
        }
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        if loginStatusInfo.isLogin {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyClassCell") as! MyClassCell
            
            cell.address.text =  "开课地点:" + myClass[indexPath.row].schoolname
            cell.className.text =  myClass[indexPath.row].coursename
            return cell
            
        }else{
            let cell = tableview.dequeueReusableCellWithIdentifier("NodateCell") as! NodateCell
            return cell
        }
        
        
    }


    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if myClass.isEmpty {
            return 400
            
        }else{
            return 40
        }
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "我的课程"
    }

}
