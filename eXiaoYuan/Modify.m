//
//  Modify.m
//
//
//  Created by yd on 15/11/20.
//
//

#import "Modify.h"

@interface Modify ()<UITextFieldDelegate>
{
    UITextField *userName;
    UITextField *userPsw;
    UITextField *userModify;
}
@end

@implementation Modify

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    
}

-(void)createView{
    //    NSArray *title = @[@"请输入将要修改密码的账号",@"请输入原密码",@"请输入新密码"];
    userName = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/6, CGRectGetHeight([UIScreen mainScreen].bounds)/6, CGRectGetWidth([UIScreen mainScreen].bounds)*2/3 , 44)];
    userName.placeholder  = @"请输入将要修改密码的账号";
    userName.borderStyle  = UITextBorderStyleRoundedRect;
    userName.backgroundColor  = [UIColor whiteColor];
    userName.textColor = [UIColor blackColor];
    userName.delegate = self;
    [self.view addSubview:userName];
    
    userPsw = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/6, CGRectGetMaxY(userName.frame)+5, CGRectGetWidth([UIScreen mainScreen].bounds)*2/3 , 44)];
    userPsw.placeholder  = @"请输入原密码";
    userPsw.backgroundColor  = [UIColor whiteColor];
    userPsw.textColor = [UIColor blackColor];
    userPsw.borderStyle = UITextBorderStyleRoundedRect;
    userPsw.delegate = self;
    userPsw.secureTextEntry = YES;
    [self.view addSubview:userPsw];
    
    userModify = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/6, CGRectGetMaxY(userPsw.frame)+5, CGRectGetWidth([UIScreen mainScreen].bounds)*2/3 , 44)];
    userModify.placeholder  = @"请输入新密码";
    userModify.backgroundColor  = [UIColor whiteColor];
    userModify.textColor = [UIColor blackColor];
    userModify.delegate = self;
    userModify.borderStyle = UITextBorderStyleRoundedRect;
    userModify.secureTextEntry = YES;
    [self.view addSubview:userModify];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame  = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/3, CGRectGetMaxY(userModify.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)/3, 44);
    [btn setTitle:@"修改密码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:0.308 green:0.820 blue:0.754 alpha:1.000];
    [btn addTarget:self action:@selector(modifyBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    [self.view addSubview:btn];
    
    
}


-(void)modifyBtn{
    NSLog(@"..................");
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
