//
//  ViewController.m
//  检测Wifi地址
//
//  Created by hardy on 2017/6/12.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import "HTIPHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self click];
    
 
}

- (void)click
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    NSString *reason = @"我们需要验证您的指纹来确认您的身份";
    // 判断设置是否支持指纹识别(iPhone5s+、iOS8+支持)
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        // 指纹识别只判断当前用户是否是机主
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            if(success)
            {
                NSLog(@"指纹认证成功");
            }
            else
            {
                NSLog(@"指纹认证失败");
                NSLog(@"错误码：%zd",error.code);
                NSLog(@"出错信息：%@",error);
                // 错误码 error.code
                // -1: 连续三次指纹识别错误
                // -2: 在TouchID对话框中点击了取消按钮
                // -3: 在TouchID对话框中点击了输入密码按钮
                // -4: TouchID对话框被系统取消，例如按下Home或者电源键
                // -8: 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
            }
        }];
    }
    else{
        NSLog(@"TouchID设备不可用");
        NSLog(@"错误码：%zd",error.code);
        NSLog(@"出错信息：%@",error);
    }
}



@end
