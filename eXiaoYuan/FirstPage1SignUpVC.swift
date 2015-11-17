//
//  FirstPage1SignUpVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/6.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class FirstPage1SignUpVC: UITableViewController {

    
    var httpReq = HTTP.sharedInstance
    var pullDownFlag = false //下拉刷新标记
    var className = [String]()  //课程类别
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        
        self.tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewData"))
        
        //self.tableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        
        
        
        //注册cell
        tableView.registerNib(UINib(nibName: "ClassNameCell", bundle: nil), forCellReuseIdentifier: "ClassNameCell")
        
        //获取新闻类别列表通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("firstPage1SignUpVCProcess:"), name: "FirstPage1SignUpVC", object: nil)
        
        setNavigationBar()
        
        self.navigationItem.title = "培训课程"
        NSLog("self.navigationItem.title = \(self.navigationItem.title)")
        
        httpReq.getClassName("FirstPage1SignUpVC")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    func firstPage1SignUpVCProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("dataTemp = \(dataTemp)")
            
            let data = dataTemp["data"]
            
            //检测是否是下拉刷新
            if pullDownFlag {
                className = [] //新闻类别不相同是清空数组
                pullDownFlag = false
            }
            
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到新闻数据数据")
                for var i = 0 ; i < data.count ; i++ {
                    className.append(data[i].stringValue)
                }
            }
            
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
        httpReq.getClassName("FirstPage1SignUpVC")
        
    }

//    /**
//    上拉加载更多
//    */
//    func loadMoreData(){
//        NSLog("加载更多数据")
//        self.tableView.footer.endRefreshing()
//        //从当前数据游标处再添加10条数据
//        let startNo = ((className.count/10) * 10 ) +  (className.count%10) + 1
//        let endN0 = startNo + 10
//        httpReq.getNews(currentNewsClass, startRow: startNo.description, toRow: endN0.description, notificationName: self.getNews)
//        
//    }
    

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
        return className.count
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClassNameCell") as! ClassNameCell

        cell.courseName.text = className[indexPath.row] + "课程"
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("你选择的是：\(className[indexPath.row])")
        var courseSubNameVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CourseSubNameVC") as! CourseSubNameVC
        courseSubNameVC.courseName = className[indexPath.row]
        
        self.navigationController?.pushViewController(courseSubNameVC, animated: true)
    }

    /**
    Navigation外观
    */
    func setNavigationBar(){
        //        navigationBar常用属性
        //        一. 对navigationBar直接配置,所以该操作对每一界面navigationBar上显示的内容都会有影响(效果是一样的)
        //        1.修改navigationBar颜色
        //        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        //
        //        2.关闭navigationBar的毛玻璃效果
        //        self.navigationController.navigationBar.translucent = NO;
        //        3.将navigationBar隐藏掉
        //
        //        self.navigationController.navigationBarHidden = YES;
        //
        //        4.给navigationBar设置图片
        //        不同尺寸的图片效果不同:
        //        1.320 * 44,只会给navigationBar附上图片
        //
        //        2.高度小于44,以及大于44且小于64:会平铺navigationBar以及状态条上显示
        //
        //        3.高度等于64:整个图片在navigationBar以及状态条上显示
        
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
