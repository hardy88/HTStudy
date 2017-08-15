//
//  HXKSForgetPassword.m
//  HXKS
//
//  Created by hardy on 2017/8/1.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


// vc
#import "HXKSForgetPassword.h"

// view
#import "HTSeparator.h"
#import "HTValidateView.h"
#import "HTCustomTextField.h"
#import "HTValidateTextField.h"
#import "HTConfirmTextField.h"
#import "HTCustomButton.h"

// Request
#import "HXKSValidateRequest.h"
#import "HXKSResetPasswordRequest.h"



typedef NS_ENUM(NSInteger, HXKSTextFieldTag)
{
    HTKS_TFIEDL_PHONE = 2000,
    HTKS_TFIEDL_VALIDATE = 2001,
    HTKS_TFIEDL_SETPASSWORD = 2002,
    HTKS_TFIEDL_CONFIRMPASSWORD = 2003
};

@interface HXKSForgetPassword ()<UITextFieldDelegate>
{
     UIScrollView *scView;
}
// 手机号
@property(nonatomic,copy)NSString *phoneStr;
// 验证码
@property(nonatomic,copy)NSString *validateStr;
// 设置登录密码
@property(nonatomic,copy)NSString *setPswStr;
// 确认登录密码
@property(nonatomic,copy)NSString *confirmPswStr;
@end

@implementation HXKSForgetPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideNavBar:NO];
}

- (void)setupBaseView
{
    self.navTitle = @"忘记密码";
    scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scView.showsVerticalScrollIndicator = NO;
    scView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scView];
    
    // 手机号
    HTCustomTextField *phoneTField = [[HTCustomTextField alloc] initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    phoneTField.placeholder = @"输入手机号码";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.font = [UIFont fontWithName:@"iconfont" size:21];
    label.text = @"\ue60b";
    phoneTField.leftView = label;
    phoneTField.returnKeyType = UIReturnKeyDone;
    phoneTField.borderStyle = UITextBorderStyleNone;
    phoneTField.delegate =self;
    phoneTField.tag = HTKS_TFIEDL_PHONE;
    [scView addSubview:phoneTField];
    
    // 验证码
    HTValidateView *countDownTime = [[HTValidateView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width -142, CGRectGetMaxY(phoneTField.frame) + 5, 130, 35) andTitle:@"获取验证码"];
    [countDownTime addTarget:self action:@selector(countDown:) forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:countDownTime];
    
    HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(CGRectGetMinX(countDownTime.frame)-8, CGRectGetMaxY(countDownTime.frame)+4, CGRectGetWidth(countDownTime.frame)+8, 1)];
    [scView addSubview:lineView];
    
    HTValidateTextField *validateTField = [[HTValidateTextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(phoneTField.frame) + 5, [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(countDownTime.frame)-22, 50)];
    validateTField.placeholder = @"输入验证码";
    validateTField.borderStyle = UITextBorderStyleNone;
    validateTField.returnKeyType = UIReturnKeyDone;
    validateTField.delegate = self;
    validateTField.tag = HTKS_TFIEDL_VALIDATE;
    [scView addSubview:validateTField];
    
    // 设置密码
    HTCustomTextField *pswTField = [[HTCustomTextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(validateTField.frame)+5, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    pswTField.placeholder = @"设置登录密码";
    UILabel *pswLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pswLabel.font = [UIFont fontWithName:@"iconfont" size:21];
    pswLabel.text = @"\ue610";
    pswTField.leftView = pswLabel;
    pswTField.borderStyle = UITextBorderStyleNone;
    pswTField.returnKeyType = UIReturnKeyDone;
    pswTField.secureTextEntry = YES;
    pswTField.delegate = self;
    pswTField.tag = HTKS_TFIEDL_SETPASSWORD;
    [scView addSubview:pswTField];
    
    // 确认密码
    HTConfirmTextField *confirmPswTField = [[HTConfirmTextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(pswTField.frame)+5, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    confirmPswTField.placeholder = @"再次输入登录密码";
    UILabel *confirmpswLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    confirmpswLabel.text = @"确认密码:";
    confirmpswLabel.font = [UIFont systemFontOfSize:15];
    confirmPswTField.leftView = confirmpswLabel;
    confirmPswTField.borderStyle = UITextBorderStyleNone;
    confirmPswTField.returnKeyType = UIReturnKeyDone;
    confirmPswTField.secureTextEntry = YES;
    confirmPswTField.delegate = self;
    confirmPswTField.tag = HTKS_TFIEDL_CONFIRMPASSWORD;
    [scView addSubview:confirmPswTField];
    
    // 立即注册
    HTCustomButton *doneButton = [HTCustomButton buttonWithType:UIButtonTypeCustom];
    [doneButton customButtonByTitle:@"完成" Ypoint:CGRectGetMaxY(confirmPswTField.frame)+ 15 FontSize:14];
    [doneButton addTarget:self action:@selector(doneRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [scView addSubview:doneButton];
}
- (void)doneRegisterClick:(UIButton*)but
{
    [self.view endEditing:YES];
    
    if ([ToolClass isEmpty:self.phoneStr])
    {
        [HTHubProgress showHintMessage:@"手机号不能为空！" onView:self.view];
    }
    else if ([ToolClass isEmpty:self.validateStr])
    {
        [HTHubProgress showHintMessage:@"请输入验证码！" onView:self.view];
    }
    else if ([ToolClass isEmpty:self.setPswStr])
    {
        [HTHubProgress showHintMessage:@"请设置登录密码！" onView:self.view];
    }
    else if (![self.confirmPswStr isEqual:self.setPswStr])
    {
        [HTHubProgress showHintMessage:@"确认密码和设置密码不一致！" onView:self.view];
    }
    else
    {
        __weak typeof(self) weakSelf = self;
        [HXKSResetPasswordRequest hxksResetPassword:self.setPswStr phoneNum:self.phoneStr messageNum:self.validateStr success:^(NSURLSessionDataTask *task, id response) {
            [HTHubProgress showHintMessage:@"设置密码成功" onView:self.view];
            [weakSelf.curNav toBack];
        } failure:^(NSURLSessionDataTask *task, id error) {
            [HTHubProgress showHintMessage:error onView:self.view];
        }];
    }
}
- (void)countDown:(UIButton*)but
{
    [self.view endEditing:YES];
    if (!self.phoneStr)
    {
        [HTHubProgress showHintMessage:@"请输入手机号!" onView:self.view];
        return;
    }
    __block NSInteger second = 60;
    
    __weak HXKSForgetPassword *weakSelf = self;
    but.userInteractionEnabled = NO;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0)
            {
                [but setTitle:[NSString stringWithFormat:@"(%ld)重发验证码",second] forState:UIControlStateNormal];
                second--;
            }
            else
            {
                dispatch_source_cancel(timer);
                but.userInteractionEnabled = YES;
                [but setTitle:@"获取验证码" forState:UIControlStateNormal];
            }
        });
    });
    //启动源
    dispatch_resume(timer);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [weakSelf startValidateRequest];
    });
}

- (void)startValidateRequest
{
    [HXKSValidateRequest startValidateRequestWithParameter:self.phoneStr success:^(NSURLSessionDataTask *task, id responseObj) {
        [HTHubProgress showHintMessage:@"发送验证码成功" onView:self.view];
    } failure:^(NSURLSessionDataTask *task, id err) {
       [HTHubProgress showHintMessage:err onView:self.view];
    }];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.view endEditing:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger tag = textField.tag;
    switch (tag)
    {
        case HTKS_TFIEDL_PHONE:
        {
            if ([ToolClass isEmpty:textField.text])
            {
                [HTHubProgress showHintMessage:@"手机号不能为空!" onView:self.view];
            }
            else if ([ToolClass isPhoneNum:textField.text])
            {
                self.phoneStr = textField.text;
            }
            else
            {
                [HTHubProgress showHintMessage:@"手机号格式不正确!" onView:self.view];
            }
        }
            break;
            
        case HTKS_TFIEDL_VALIDATE:
            self.validateStr = textField.text;
            break;
        case HTKS_TFIEDL_SETPASSWORD:
            self.setPswStr = textField.text;
            break;
            
        case HTKS_TFIEDL_CONFIRMPASSWORD:
            self.confirmPswStr = textField.text;
            break;
        
    }
}
@end
