//
//  AboutYaoDe.m
//
//
//  Created by yd on 15/11/20.
//
//

#import "AboutYaoDe.h"

@interface AboutYaoDe ()

@end

@implementation AboutYaoDe

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"关于要得100";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    
    
}

-(void)createView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/3, CGRectGetHeight([UIScreen mainScreen].bounds)/6, CGRectGetWidth([UIScreen mainScreen].bounds)/3, CGRectGetWidth([UIScreen mainScreen].bounds)/3)];
    imageView.image = [UIImage imageNamed:@"大学生之家.jpg"];
    [self.view addSubview:imageView];
    
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)*2/3, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    version.text =@"Version 1.0.0";
    version.textColor  = [UIColor colorWithRed:0.594 green:0.515 blue:1.000 alpha:1.000];
    version.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:version];
    
    UILabel *webSite = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(version.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    webSite.text =@"www.yaode100.com";
    webSite.textColor  = [UIColor colorWithRed:0.594 green:0.515 blue:1.000 alpha:1.000];
    webSite.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:webSite];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(webSite.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    label.text =@"Copyright @ 2015 All right revered";
    label.textColor  = [UIColor colorWithRed:0.594 green:0.515 blue:1.000 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}


-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
