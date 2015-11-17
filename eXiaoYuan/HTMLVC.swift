//
//  HTMLVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/4.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class HTMLVC: UIViewController,UIWebViewDelegate {

    func addPermissionUsr(){
        var loginVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        self.presentViewController(loginVC, animated: true, completion: { () -> Void in
            
        })
    }

    
    
    @IBAction func commentBtnClk(sender: UIButton) {
        NSLog("评论按钮点击")
        //只有注册的用户才能进行评论,或注册
        if usrInfo.usr.isEmpty {
            if loginStatusInfo.isLogin {
                var commentVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CommentVC") as! CommentVC
                commentVC.newsCell = self.newsCell
                self.navigationController?.pushViewController(commentVC, animated: true)
                
                
            }else{//未登录会进行登录或注册
                addPermissionUsr()
            }
            
        }
        
        
    }
    @IBOutlet var webView: UIWebView!
    
    var newsCell = NewsCell()
    
    func webviewSet(){
        webView.delegate = self
        
        webView.sizeToFit()
        
        webView.loadHTMLString(newsCell.content, baseURL: NSURL())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webviewSet()
        self.navigationItem.title = newsCell.title
    }

    
    func loginVCProcess(sender:NSNotification){
        if  let senderTemp:AnyObject = sender.object {
            var dataTemp = JSON(sender.object!)
            NSLog("loginResult = \(dataTemp)")
            if "100" == dataTemp["result"].stringValue{
                NSLog("获取到数据")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }

    /**
    webview代理
    
    - parameter webView:        webView description
    - parameter request:        request description
    - parameter navigationType: navigationType description
    
    - returns: return value description
    */
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    /**
    webview代理
    
    - parameter webView: webView description
    */
    func webViewDidStartLoad(webView: UIWebView){
        
    }
    
    /**
    webview代理
    
    - parameter webView: webView description
    */
    func webViewDidFinishLoad(webView: UIWebView){

        
    }
    
    /**
    webview代理
    
    - parameter webView: webView description
    - parameter error:   error description
    */
    func webView(webView: UIWebView, didFailLoadWithError error: NSError){
        
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
