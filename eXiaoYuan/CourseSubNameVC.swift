//
//  CourseSubNameVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/6.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//


import UIKit
import SDWebImage
import SwiftyJSON

class CourseSubNameVC: UITableViewController {


    var courseName = ""
    
    var header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 110))
    var img = UIImageView(frame: CGRect(x: 8, y: 8, width: 90, height: 90))
    var content = UILabel(frame: CGRect(x: 106, y: 10, width: UIScreen.mainScreen().bounds.width - 130, height: 80))
    
    var spareLine = UIView(frame: CGRect(x: 0 , y: 105, width: UIScreen.mainScreen().bounds.width, height: 2))
    
    var httpReq = HTTP.sharedInstance
    var pullDownFlag = false //下拉刷新标记
    
    //课程名称
    var subCourseName = [CourseInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        content.numberOfLines = 0
        //content.text = newsCell.title
        //img.sd_setImageWithURL(NSURL(string: newsCell.icon))
        spareLine.backgroundColor = UIColor.redColor()
        header.addSubview(spareLine)
        header.addSubview(img)
        header.addSubview(content)
        
        header.backgroundColor = UIColor.clearColor()
        
        self.tableView.tableHeaderView = header
        
        
        self.tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewData"))
        
        //self.tableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        
        
        
        //注册cell
        tableView.registerNib(UINib(nibName: "ClassNameCell", bundle: nil), forCellReuseIdentifier: "ClassNameCell")
        
        //获取新闻类别列表通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("courseSubNameVCProcess:"), name: "CourseSubNameVC", object: nil)
        
        
        
        httpReq.getClassSubName(courseName, notificationName: "CourseSubNameVC")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    func courseSubNameVCProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("dataTemp = \(dataTemp)")
            
            let data = dataTemp["data"]
            
            //检测是否是下拉刷新
            if pullDownFlag {
                subCourseName = [] //新闻类别不相同是清空数组
                pullDownFlag = false
            }
            
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到新闻数据数据")
                for var i = 0 ; i < data.count ; i++ {
                    var temp = data[i]
                    var courseInfoTemp = CourseInfo()
                    courseInfoTemp.c_icon = temp["c_icon"].stringValue
                    courseInfoTemp.c_name = temp["c_name"].stringValue
                    courseInfoTemp.c_scid = temp["c_scid"].stringValue
                    courseInfoTemp.keyid = temp["keyid"].stringValue
                    courseInfoTemp.creattime = temp["creattime"].stringValue
                    courseInfoTemp.c_keyid = temp["c_keyid"].stringValue
                    courseInfoTemp.c_brief = temp["c_brief"].stringValue
                    courseInfoTemp.name = temp["name"].stringValue
                    
                    subCourseName.append(courseInfoTemp)
                }
            }
            
            
            content.text = subCourseName[0].c_name + "火热报名中"
            content.textColor = UIColor.redColor()
            img.sd_setImageWithURL(NSURL(string: self.subCourseName[0].c_icon))
            
            tableView.reloadData()
        }
    }
    
    /**
    下拉刷新
    */
    func loadNewData(){
        NSLog("一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法")
        self.tableView.header.endRefreshing()
        pullDownFlag = true //下拉标记
        httpReq.getClassSubName(courseName, notificationName: "CourseSubNameVC")
        
    }
    
//        /**
//        上拉加载更多
//        */
//        func loadMoreData(){
//            NSLog("加载更多数据")
//            self.tableView.footer.endRefreshing()
//            //从当前数据游标处再添加10条数据
//            let startNo = ((subCourseName.count/10) * 10 ) +  (className.count%10) + 1
//            let endN0 = startNo + 10
//            
//    
//        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return subCourseName.count
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClassNameCell") as! ClassNameCell
        
        cell.courseName.text = subCourseName[indexPath.row].name + "报名进行中..."
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("你选择的是：\(subCourseName[indexPath.row])")
        var signUpVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignUpVC") as! SignUpVC
        signUpVC.courseInfo = subCourseName[indexPath.row]
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
   
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

