//
//  CommentVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/5.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class CommentVC: UITableViewController {

    //当前评论的新闻信息新闻
    var newsCell = NewsCell()
    var httpReq = HTTP.sharedInstance
    
    var commentArry = [Comment]()
    /// 下拉刷新标记
    var pullRefFlag = false
    
    
    var header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 110))
    var img = UIImageView(frame: CGRect(x: 8, y: 8, width: 90, height: 90))
    var content = UILabel(frame: CGRect(x: 106, y: 10, width: UIScreen.mainScreen().bounds.width - 130, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        content.numberOfLines = 0
        content.text = newsCell.title
        img.sd_setImageWithURL(NSURL(string: newsCell.icon))
        header.addSubview(img)
        header.addSubview(content)
        
        header.backgroundColor = UIColor.clearColor()
        
        self.tableView.tableHeaderView = header
        
        self.tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewData"))
        
        self.tableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        
        
        //获取新闻类别列表通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("commentVCProcess:"), name: "commentVC", object: nil)
        httpReq.newsComment(newsCell.keyid, startNo: "1", endNo: "10", notificationName: "commentVC")
        
        //注册cell
        tableView.registerNib(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        
        setNavigationBar()

    }
    
    
    /**
    下拉刷新
    */
    func loadNewData(){
        NSLog("一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法")
        self.tableView.header.endRefreshing()
        httpReq.newsComment(newsCell.keyid, startNo: "1", endNo: "10", notificationName: "commentVC")
        pullRefFlag = true
    }
    
    /**
    上拉加载更多
    */
    func loadMoreData(){
        NSLog("加载更多数据")
        self.tableView.footer.endRefreshing()
        //从当前数据游标处再添加10条数据
        let startNo = ((commentArry.count/10) * 10 ) +  (commentArry.count%10) + 1
        let endN0 = startNo + 10
        httpReq.newsComment(newsCell.keyid, startNo: startNo.description, endNo: endN0.description, notificationName: "commentVC")
        
        
    }

    
    /**
    评论内容获取处理
    
    - parameter sender: sender description
    */
    func commentVCProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("dataTemp = \(dataTemp)")
            
            
            
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到数据")
                
                /**
                *  如果是下拉刷新，清空以前的数组
                */
                if pullRefFlag {
                    commentArry = []
                    pullRefFlag = false
                }
                
                
                var data = dataTemp["data"]
                for var i = 0 ; i < data.count ; i++ {
                    var dataTemp = data[i]
                    var commentTemp = Comment()
                    commentTemp.isread = dataTemp["isread"].stringValue
                    commentTemp.content = dataTemp["content"].stringValue
                    commentTemp.newsid = dataTemp["newsid"].stringValue
                    commentTemp.pbname = dataTemp["pbname"].stringValue
                    commentTemp.keyid = dataTemp["keyid"].stringValue
                    commentTemp.fid = dataTemp["fid"].stringValue
                    commentTemp.creattime = dataTemp["creattime"].stringValue
                    commentTemp.publishid = dataTemp["publishid"].stringValue
                    
                    var replymsgdata = dataTemp["replymsgdata"]
                    var subComment = [Comment]()
                    
                    
                    //获取二级评论
                    for var j = 0 ; j < replymsgdata.count ; j++ {
                        var subCommentTemp = Comment()
                        var dataTemp = replymsgdata[i]
                        
                        subCommentTemp.isread = dataTemp["isread"].stringValue
                        subCommentTemp.content = dataTemp["content"].stringValue
                        subCommentTemp.newsid = dataTemp["newsid"].stringValue
                        subCommentTemp.pbname = dataTemp["pbname"].stringValue
                        subCommentTemp.keyid = dataTemp["keyid"].stringValue
                        subCommentTemp.fid = dataTemp["fid"].stringValue
                        subCommentTemp.creattime = dataTemp["creattime"].stringValue
                        subCommentTemp.publishid = dataTemp["publishid"].stringValue
                        
                        subComment.append(subCommentTemp)
                    }
                    commentTemp.subComment = subComment
                    
                    //添加评论到数组
                    commentArry.append(commentTemp)
                    
                }
                
                tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        NSLog("commentArry.count = \(commentArry.count)")
        return commentArry.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        NSLog("commentArry[section].subComment.count = \(commentArry[section].subComment.count)")
        return commentArry[section].subComment.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
        
        var headerPara = CommentHeader()
        headerPara.author = commentArry[indexPath.section].subComment[indexPath.row].pbname
        headerPara.time = commentArry[indexPath.section].subComment[indexPath.row].creattime
        headerPara.content = commentArry[indexPath.section].subComment[indexPath.row].content
        cell.header = headerPara
        
        return cell
    }
    
    /**
    tableView viewForHeaderInSection
    */
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var tableViewHeaderView = NSBundle.mainBundle().loadNibNamed("TableViewHeaderView", owner: nil, options: nil).last as! TableViewHeaderView
        var headerPara = CommentHeader()
        headerPara.author = commentArry[section].pbname
        headerPara.time = commentArry[section].creattime
        headerPara.content = commentArry[section].content
        tableViewHeaderView.header = headerPara
        
        return tableViewHeaderView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
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

}
