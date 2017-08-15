//
//  HXLoginTool.m
//  HXKS
//
//  Created by hardy on 2017/7/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSManager.h"
// vc
#import "HTRegisterViewController.h"
#import "ProfileViewController.h"
#import "HTHomeViewCotroller.h"
#import "HXKSLoginViewController.h"
// other
#import "AppDelegate.h"
#import "SSKeychain.h"
#import "LoginRequest.h"
#import "HXKSLogoutRequest.h"
#import "SSKeychain.h"

@implementation HXKSManager

+ (instancetype)manager
{
    static HXKSManager * manager= nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[HXKSManager alloc] init];
    });
    return manager;
}

/**
 存储登录用户名
 
 @param account 登录用户名
 @return 存储成功与否 YES-存储成功  NO- 存储失败
 */
+ (BOOL)saveLoginAccount:(NSString*)account
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:account forKey:@"HXKS_LOGIN_ACCOUNT"];
    return [def synchronize];
}

/**
 获取登录用户名
 
 @return 登录用户名
 */
+ (NSString *)getLoginAccount
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:@"HXKS_LOGIN_ACCOUNT"];
}

+ (NSString *)getLoginPassword
{
    NSString *userName = [HXKSManager getLoginAccount];
    // 如果上一次登录过则自动填写用户名和密码
    if (![ToolClass isEmpty:userName])
    {
        if ([SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:userName])
        {
            NSString *password = [SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:userName];
            return  password;
        }
    }
    return @"";
}


+ (void)jumpToMainPage
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    ProfileViewController *side = [[ProfileViewController alloc] init];
    HTHomeViewCotroller *content = [[HTHomeViewCotroller alloc] init];
    tempAppDelegate.mainVC = [[HTNavigationController alloc] initWithRootViewController:content];
    tempAppDelegate.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:side andMainView:tempAppDelegate.mainVC];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    tempAppDelegate.window.rootViewController = tempAppDelegate.LeftSlideVC ;
}

/**
 自动登录
 */
+ (void)hxksAutoLoginSuccess:(void (^)(NSURLSessionDataTask *task,id response))callBack
                        fail:(void (^)(NSURLSessionDataTask *task,id error))failure
{
    NSString *userName = [HXKSManager getLoginAccount];
    // 如果上一次登录过则自动填写用户名和密码
    if (![ToolClass isEmpty:userName])
    {
        if ([SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:userName])
        {
            NSString *password = [SSKeychain passwordForService:KEYCHAIN_SERVICENAME account:userName];
            
            [HXKSManager hxksLoginWithUserName:userName passWord:password success:callBack failure:failure];
        }
    }
    else
    {
        failure(nil,@"登录失败");
    }
}
+ (void)hxksLoginWithUserName:(NSString *)userName
                     passWord:(NSString *)password
                      success:(void (^)(NSURLSessionDataTask *task, id response))success
                      failure:(void (^)(NSURLSessionDataTask *task, id err))fail
{
    [LoginRequest loginWithUserName:userName password:password success:success failure:fail];
}
+ (void)hxksLogoutSuccess:(void (^)(NSURLSessionDataTask *task,id response))success
                     fail:(void (^)(NSURLSessionDataTask *task,id error))failure
{
    [HXKSLogoutRequest hxksLogoutRequest:nil success:success failure:failure];
}

// 退出登录
+ (void)logout:(UINavigationController*)nav
{
    if ([nav isMemberOfClass:[UINavigationController class]])
    {
        HXKSLoginViewController *vc = [[HXKSLoginViewController alloc] init];
        [nav pushViewController:vc animated:YES];
    }
    else
    {
        NSLog(@"");
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
         HXKSLoginViewController *vc = [[HXKSLoginViewController alloc] init];
        tempAppDelegate.window.rootViewController = vc;
    }
}

@end
