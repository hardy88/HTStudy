//
//  MainViewController.m
//  CF通讯
//
//  Created by hardy on 2017/2/8.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "MainViewController.h"

#import "HTSocket.h"

#import "WeChatViewController.h"

@interface MainViewController ()<UITextFieldDelegate>



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    UITextField *userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 80, 120, 30)];
    userNameTF.placeholder = @"请输入用户名";
    userNameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    userNameTF.delegate = self;
    [self.view addSubview:userNameTF];
    
    
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 120, 120, 30)];
    passwordTF.placeholder = @"请输入密码";
    passwordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordTF.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordTF.delegate = self;
    [self.view addSubview:passwordTF];
    
    
    
    UIButton *regist = [UIButton buttonWithType:UIButtonTypeCustom];
    regist.frame = CGRectMake(12, 150, 50, 30);
    [regist setTitle:@"注册" forState:UIControlStateNormal];
    [regist setBackgroundColor:[UIColor purpleColor]];
    [regist addTarget:self action:@selector(registeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regist];
    
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(72, 150, 50, 30);
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor purpleColor]];
    [login addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    
}

- (void)registeButtonClick:(UIButton*)but
{
//    HTSocket *manager = [HTSocket manager];
//    [manager url:@"192.168.1.181"
//            port:@"30000"
//          method:@"ht_register"
//         message:@"你好，我要注册"
//        callBack:^(id response) {
//            
//            NSLog(@"注册信息：%@",response);
//            
//        }];
    

    
}

- (void)loginButtonClick:(UIButton*)but
{
//    HTSocket *manager = [HTSocket manager];
//    [manager url:@"192.168.1.181"
//            port:@"30000"
//          method:@"ht_login"
//         message:@"你好，我要登录"
//        callBack:^(id response) {
//            
//            NSLog(@"登录信息：%@",response);
//            
//        }];
//    
    WeChatViewController *vc  = [[WeChatViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
