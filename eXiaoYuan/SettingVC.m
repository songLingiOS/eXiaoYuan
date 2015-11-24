//
//  SettingVC.m
//  eXiaoYuan
//
//  Created by iosnull on 15/11/19.
//  Copyright (c) 2015年 yongzhikeji. All rights reserved.
//

#import "SettingVC.h"

#import "Modify.h"
#import "AboutYaoDe.h"



@interface SettingVC () <UIAlertViewDelegate>

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}




/**
 * //你自己从这里push你的页面，先弄好界面
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了tableView");
    
    Modify *modify = [[Modify alloc] init];
    AboutYaoDe *about = [[AboutYaoDe alloc] init];
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.navigationController pushViewController:modify animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系客服" message:@"客服热线:10086" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 100;
        alert.delegate = self;
        [alert show];
        
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self.navigationController pushViewController:about animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"退出登陆" message:@"确定退出？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert1.tag = 101;
        alert1.delegate = self;
        [alert1 show];
    }
    
    
    
}


-(void)create:(NSString *)title : (NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.delegate = self;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *allString = [NSString stringWithFormat:@"tel:10086"];
    if (alertView.tag == 100 && buttonIndex == 0) {
        NSLog(@"xxxxxxxx");
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
    }
    if (alertView.tag == 101 && buttonIndex == 0) {
        NSLog(@"0000000");
    }
    
    
}




/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
