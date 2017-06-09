//
//  HXLoginViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

// vc
#import "HXLoginViewController.h"
#import "HTRegisterViewController.h"

// view
#import "HTCustomTextField.h"
#import "HTCustomButton.h"
#import "ProgressHUD.h"

// other
#import "AppDelegate.h"


@interface HXLoginViewController ()<UITextFieldDelegate>

@end

@implementation HXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavBar:YES];
}
- (void)setupBaseView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *headerView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, 230)];
    headerView.image = [UIImage imageNamed:@"htLogin.png"];
    [self.view addSubview:headerView];
    

    HTCustomTextField *userNameTField = [[HTCustomTextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(headerView.frame)+30, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    userNameTField.placeholder = @"用户名";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.font = [UIFont fontWithName:@"iconfont" size:21];
    label.text = @"\ue60b";
    userNameTField.leftView = label;
    userNameTField.borderStyle = UITextBorderStyleNone;
    userNameTField.delegate = self;
    [self.view addSubview:userNameTField];
    
    HTCustomTextField *pswTField = [[HTCustomTextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(userNameTField.frame), [UIScreen mainScreen].bounds.size.width - 20, 50)];
    UILabel *pswlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    pswlabel.font = [UIFont fontWithName:@"iconfont" size:21];
    pswlabel.text = @"\ue610";
    pswTField.leftView = pswlabel;
    pswTField.placeholder = @"密码";
    pswTField.borderStyle = UITextBorderStyleNone;
    pswTField.delegate = self;
    [self.view addSubview:pswTField];
    
    HTCustomButton *loginButton = [HTCustomButton buttonWithType:UIButtonTypeCustom];
    [loginButton customButtonByTitle:@"登录" Ypoint:CGRectGetMaxY(pswTField.frame)+ 15 FontSize:15];
    [loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *forgetPsw = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPsw.frame = CGRectMake(12, CGRectGetMaxY(loginButton.frame) + 30, 100, 30);
    [forgetPsw setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetPsw.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetPsw setTitleColor:[UIColor colorWithHexString:@"#939393"] forState:UIControlStateNormal];
    [forgetPsw addTarget:self action:@selector(forgetPswClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPsw];
    
    UIButton *registerBut = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-112, CGRectGetMaxY(loginButton.frame) + 30, 100, 30);
    [registerBut setTitle:@"新用户注册" forState:UIControlStateNormal];
    registerBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBut setTitleColor:[UIColor colorWithHexString:@"#DE001F"] forState:UIControlStateNormal];
    [registerBut addTarget:self action:@selector(registerPswClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBut];
}

- (void)loginClick:(UIButton*)but
{
     AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      tempAppDelegate.window.rootViewController = tempAppDelegate.LeftSlideVC ;
}
- (void)forgetPswClick:(UIButton*)but
{
    
}
- (void)registerPswClick:(UIButton*)but
{
    HTRegisterViewController *vc = [[HTRegisterViewController alloc] init];
    [self.curNav toNext:vc];
}

- (void)hide{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
@end
