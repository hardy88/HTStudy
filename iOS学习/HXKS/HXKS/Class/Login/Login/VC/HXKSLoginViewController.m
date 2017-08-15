//
//  HXLoginViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

// vc
#import "HXKSLoginViewController.h"
#import "HTRegisterViewController.h"
#import "ProfileViewController.h"
#import "HTHomeViewCotroller.h"
#import "HXKSForgetPassword.h"



// view
#import "HTCustomTextField.h"
#import "HTCustomButton.h"
#import "ProgressHUD.h"
#import "MBProgressHUD+MJ.h"

// other
#import "AppDelegate.h"
#import "HXKSManager.h"
#import "LoginRequest.h"
#import "HTHubProgress.h"

#import "SSKeychain.h"




typedef NS_ENUM(NSInteger, HTTFieldLoginTag)
{
    HTKS_LOGIN_TAG_USERNAME = 400,
    HTKS_LOGIN_TAG_PASSWORD = 401,
};


@interface HXKSLoginViewController ()<UITextFieldDelegate,htLoginRequestDelegate>

@property(nonatomic,copy)NSString *userNameStr;

@property(nonatomic,copy)NSString *passwordStr;

@end

@implementation HXKSLoginViewController

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
    userNameTField.tag = HTKS_LOGIN_TAG_USERNAME;
    [self.view addSubview:userNameTField];
    
    HTCustomTextField *pswTField = [[HTCustomTextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(userNameTField.frame), [UIScreen mainScreen].bounds.size.width - 20, 50)];
    UILabel *pswlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    pswlabel.font = [UIFont fontWithName:@"iconfont" size:21];
    pswlabel.text = @"\ue610";
    pswTField.leftView = pswlabel;
    pswTField.placeholder = @"密码";
    pswTField.borderStyle = UITextBorderStyleNone;
    pswTField.delegate = self;
    pswTField.secureTextEntry = YES;
    pswTField.tag = HTKS_LOGIN_TAG_PASSWORD;
    [self.view addSubview:pswTField];
    
    
    // 如果上一次登录过则自动填写用户名和密码
    if (![ToolClass isEmpty:[HXKSManager getLoginAccount]])
    {
        userNameTField.text = [HXKSManager getLoginAccount];
        self.userNameStr = [HXKSManager getLoginAccount];
        if ([SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:[HXKSManager getLoginAccount]])
        {
            NSString *returnPassword = [SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:self.userNameStr];
            pswTField.text = returnPassword;
            self.passwordStr = returnPassword;
        }
    }
    
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
    
//    UIButton *registerBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    registerBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-112, CGRectGetMaxY(loginButton.frame) + 30, 100, 30);
//    [registerBut setTitle:@"新用户注册" forState:UIControlStateNormal];
//    registerBut.titleLabel.font = [UIFont systemFontOfSize:14];
//    [registerBut setTitleColor:[UIColor colorWithHexString:@"#DE001F"] forState:UIControlStateNormal];
//    [registerBut addTarget:self action:@selector(registerPswClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registerBut];
}

- (void)loginClick:(UIButton*)but
{
//    [HTHubProgress showHintMessage:@"正在加载..." onView:self.view];
    
    [self.view endEditing:YES];
    
    if ([ToolClass isEmpty:self.userNameStr])
    {
        [HTHubProgress showHintMessage:@"用户名不能为空！" onView:self.view];
    }
    else if ([ToolClass isEmpty:self.passwordStr])
    {
        [HTHubProgress showHintMessage:@"密码不能为空！" onView:self.view];
    }
    else
    {
        [HTHubProgress showWaitMessage:@"正在登录。。。" onView:self.view];
        __weak typeof(self) weakSelf = self;
        [LoginRequest loginWithUserName:self.userNameStr password:self.passwordStr success:^(NSURLSessionDataTask *task, id response) {
            
            [HTHubProgress hideHub:weakSelf.view];
            if (![SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:weakSelf.userNameStr])
            {
                //如果没设置密码则 设定密码 并存储
                [SSKeychain setPassword:weakSelf.passwordStr forService:KEYCHAIN_SERVICENAME account:weakSelf.userNameStr];
                //打印密码信息
                NSString *retrieveuuid = [SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:weakSelf.userNameStr];
                
                // 存储登录用户名
                [HXKSManager saveLoginAccount:weakSelf.userNameStr];
            }
            [HXKSManager jumpToMainPage];
            
        } failure:^(NSURLSessionDataTask *task, id error) {
            [HTHubProgress hideHub:self.view];
            [HTHubProgress showHintMessage:error onView:self.view];
            
            [HXKSManager jumpToMainPage];
        }];
        
    }
}
- (void)forgetPswClick:(UIButton*)but
{
    HXKSForgetPassword *vc = [[HXKSForgetPassword alloc] init];
    [self.curNav toNext:vc];
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
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    NSInteger tag = textField.tag;
    switch (tag)
    {
        case HTKS_LOGIN_TAG_USERNAME:
        {
            self.userNameStr = textField.text;
        }
        break;
            
        case HTKS_LOGIN_TAG_PASSWORD:
            self.passwordStr = textField.text;
            break;
    }
}

#pragma mark --- LoginRequestDelegate
- (void)loginRequest:(LoginRequest*)request success:(id)response
{
    
}
- (void)loginRequest:(LoginRequest*)request failure:(NSError*)error
{
    
}
@end
