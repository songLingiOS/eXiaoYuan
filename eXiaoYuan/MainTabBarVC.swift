//
//  MainTabBarVC.swift
//  eXiaoYuan
//
//  Created by iosnull on 15/11/10.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    
    /**
    tabbar
    */
    var itemNameArray:[String] = ["firstPage","signUp","profile"]
    var itemNameSelectArray:[String] = ["firstPage_sel","signUp_sel","profile_sel"]
    
    func configTabBar() {
        var count:Int = 0;
        let items = self.tabBar.items
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
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(red: 43/255, green: 184/255, blue: 170/255, alpha: 1.0)], forState: UIControlState.Selected)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
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
