//
//  FirstPageVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/2.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON


func gcdExample(){
    let par = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    dispatch_async(par, { () -> Void in
        
        //延时操作
        NSThread.sleepForTimeInterval(1.0)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //主线程数据刷新
        })
        
    })
}

class FirstPageVC: UITableViewController ,SCTabBtnScrollViewDelegate{
    
    let httpReq = HTTP.sharedInstance
    
    let newsClass = "newsClass"
    let getNews =  "getNews"
    
    var newsClassArry = [NewsClassModel]()
    var newsArry = [NewsCell]()
    
    var currentNewsClass = String()
    var nextNewsClass = String()
    var pullDownFlag = false //下拉刷新标记
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.yellowColor()
        setNavigations()
        
        self.tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("loadNewData"))
        
        self.tableView.footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: Selector("loadMoreData"))
        
        
        
        //注册cell
        tableView.registerNib(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        
        //获取新闻类别列表通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector(newsClass+"Process:"), name: newsClass, object: nil)
        //获取新闻类别列表
        httpReq.newsClass(newsClass)
        
        //获取新闻类别列表通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector(getNews+"Process:"), name: getNews, object: nil)
        httpReq.getNews("1", startRow: "1", toRow: "10", notificationName: self.getNews)
        
        //设置tabbar颜色及图片
//        configTabBar()
    }

    /**
    新闻类别
    
    - parameter sender: sender description
    */
    func newsClassProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("dataTemp = \(dataTemp)")
            
            if 100 == dataTemp["result"]{
                NSLog("获取到数据")
                newsClassArry = []
                let data = dataTemp["data"]
                for var i = 0 ; i < data.count ; i++ {
                    let d = data[i]
                    let name = d["name"].stringValue
                    let creattime = d["creattime"].stringValue
                    let keyid = d["keyid"].stringValue
                    var str = NewsClassModel()
                    str.name = name
                    str.keyid = keyid
                    str.creattime = creattime
                    newsClassArry.append(str)
                }
                setNavigations()
                
                //状态机变量赋值
                currentNewsClass = newsClassArry[0].keyid
                nextNewsClass = currentNewsClass
            }
        }
    }
    
    /**
    新闻内容获取
    
    - parameter sender: sender description
    */
    func getNewsProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("dataTemp = \(dataTemp)")
            
            let data = dataTemp["data"]
            
            //状态机切换标记
            if nextNewsClass != currentNewsClass {
                newsArry = [] //新闻类别不相同是清空数组
                nextNewsClass = currentNewsClass
            }
            
            //检测是否是下拉刷新
            if pullDownFlag {
                newsArry = [] //新闻类别不相同是清空数组
                pullDownFlag = false
            }
            
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到新闻数据数据")
                
                //是加载更多？还是默认的<=10条&&获取到的数据大于之前的数量
                if (newsArry.count <= 10) && (data.count == newsArry.count){
                    NSLog("当前新闻数量: \(data.count)")
                }else{
                    
                    for var i = 0 ; i < data.count ; i++ {
                        let d = data[i]
                        let content = d["content"].stringValue
                        let sort = d["sort"].stringValue
                        let title = d["title"].stringValue
                        
                        let isrecommend = d["isrecommend"].stringValue
                        let keyid = d["keyid"].stringValue
                        let creattime = d["creattime"].stringValue
                        
                        let ncid = d["ncid"].stringValue
                        let icon = d["icon"].stringValue
                        
                        var str = NewsCell()
                        str.content = content
                        str.sort = sort
                        str.title = title
                        str.isrecommend = isrecommend
                        str.keyid = keyid
                        str.creattime = creattime
                        str.ncid = ncid
                        str.icon = icon
                        
                        newsArry.append(str)
                    }

                }
                
            }
            
            if "10011" == dataTemp["result"].stringValue{
                
                SVProgressHUD.show()
                SVProgressHUD.showErrorWithStatus("无更多数据")

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
        
        if currentNewsClass.isEmpty {//第一次进入系统时没有网络
            currentNewsClass = "1"
        }
        httpReq.newsClass(newsClass)
        httpReq.getNews(currentNewsClass, startRow: "1", toRow: "10", notificationName: self.getNews)
    }
    
    /**
    上拉加载更多
    */
    func loadMoreData(){
        NSLog("加载更多数据")
        self.tableView.footer.endRefreshing()
        //从当前数据游标处再添加10条数据
        let startNo = ((newsArry.count/10) * 10 ) +  (newsArry.count%10) + 1
        let endN0 = startNo + 10
        httpReq.getNews(currentNewsClass, startRow: startNo.description, toRow: endN0.description, notificationName: self.getNews)
        
    }
    
    
    
    
    
    /**
    导航栏
    */
    func setNavigations(){
        
        var nameArry:[String] = [String]()
        
        for var i = 0 ; i < newsClassArry.count ; i++ {
            nameArry.append(newsClassArry[i].name)
        }
        
        
        var name = NSMutableArray(array: nameArry)
        
        var sctab = SCTabBtnScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        sctab.numOfBtnsShownInScreen = 4
        sctab.duration = 0.2
        sctab.btnHeight = 40
        sctab.test = 1.5
        
        sctab.titleSelectedColor = UIColor.whiteColor()
        sctab.titleUnSelectedColor = UIColor.whiteColor()
        
        sctab.showIndicator = false
        
        sctab.ScrollDelegate = self
        
        sctab.backgroundColor = UIColor.clearColor()
        
        sctab.initTabBtnWithBtnTitleArr(name)
        
        self.navigationItem.titleView = sctab
        
        setNavigationBar()
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
    
    

    
    //取消通知订阅
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //清理图片内存
        SDImageCache.sharedImageCache().clearMemory()
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
        return newsArry.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("InfoCell") as! InfoCell
        cell.setCell = newsArry[indexPath.row]
        return cell
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var htmlVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HTMLVC") as! HTMLVC
        htmlVC.newsCell = newsArry[indexPath.row]
        self.navigationController?.pushViewController(htmlVC, animated: true)
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
    
    
    var itemNameArray:[String] = ["sy1","sj1","gwc1","wode1"]
    var itemNameSelectArray:[String] = ["sy_select","sj_select","gwc_select","wode_select"]
    
    func configTabBar() {
        var count:Int = 0;
        let items = self.tabBarController?.tabBar.items//self.tabBar.items
        for item in items as! [UITabBarItem] {
            var image:UIImage = UIImage(named: itemNameArray[count])!
            var selectedimage:UIImage = UIImage(named: itemNameSelectArray[count])!;
            image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            selectedimage = selectedimage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            item.selectedImage = selectedimage;
            item.image = image;
            count++;
        }
        //设置tabbarItem颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(red: 38/255, green: 168/255, blue: 231/255, alpha: 1.0)], forState: UIControlState.Selected)
    }
    

}

extension FirstPageVC {
    func didSelectBtnAtIndex(btn: UIButton!) {
        if let btnName = btn.titleLabel?.text {
            
            var keyid = ""
            for var i = 0 ; i < newsClassArry.count ; i++ {
                if btnName == newsClassArry[i].name{
                    keyid = newsClassArry[i].keyid
                }
            }
            currentNewsClass = keyid
            NSLog("点击了按钮: \(btnName)  \(keyid)")
            
            httpReq.getNews(currentNewsClass, startRow: "1", toRow: "10", notificationName: self.getNews)
        }
    }
    
    
    
    
    
    
}
