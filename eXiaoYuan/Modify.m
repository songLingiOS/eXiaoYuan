//
//  Modify.m
//  
//
//  Created by yd on 15/11/20.
//
//

#import "Modify.h"

@interface Modify ()<UITextFieldDelegate>

@end

@implementation Modify

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
}

-(void)createView{
    NSArray *title = @[@"请输入将要修改密码的账号",@"请输入原密码",@"请输入新密码"];
    for (int i = 0 ; i < title.count; i ++) {
        UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)/6, CGRectGetHeight([UIScreen mainScreen].bounds)/6, CGRectGetWidth([UIScreen mainScreen].bounds)*2/3 + (i *44), 44)];
        text.placeholder  = title[i];
        text.backgroundColor  = [UIColor colorWithWhite:0.904 alpha:1.000];
        text.textColor = [UIColor blackColor];
        text.delegate = self;
        [self.view addSubview:text];
        
        
        
        
    }
    
    
    
    
    
    
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
