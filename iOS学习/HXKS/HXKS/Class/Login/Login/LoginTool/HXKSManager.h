//
//  HXLoginTool.h
//  HXKS
//
//  Created by hardy on 2017/7/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HXKSUserInfoModel.h"

typedef NS_ENUM(NSInteger, HXLoginStatus) {
    HXLogin_Success = 0,
    HXLogin_Fail
};

typedef NS_ENUM(NSInteger, HXKSDevelopMode) {
    HXKS_DEVELOP_UNKNOW = -1, // 未知的开发模式
    HXKS_DEVELOP_DEBUG = 0, // 测试模式
    HXKS_DEVELOP_RELEASE  // 发布模式
};

@interface HXKSManager : NSObject

// 登录成功后的信息
@property(nonatomic,strong)HXKSUserInfoModel *userInfo;
// 登录状态
@property(nonatomic,assign)HXLoginStatus loginStatus;
// YES -- 登录成功    NO -- 登录失败
@property(nonatomic,assign, getter=isLoginSuccess)BOOL loginSuccess;
// YES -- 发布模式  NO -- 测试模式
@property(nonatomic,assign, getter=isReleaseMode)BOOL releaseMode;

/**
 实例化单例

 @return HXKSManager实例
 */
+ (instancetype)manager;

/**
 存储登录用户名

 @param account 登录用户名
 @return 存储成功与否 YES-存储成功  NO- 存储失败
 */
+ (BOOL)saveLoginAccount:(NSString*)account;

/**
 获取登录用户名

 @return 登录用户名
 */
+ (NSString *)getLoginAccount;

/**
 获取登录密码

 @return 登录密码
 */
+ (NSString *)getLoginPassword;

/**
 自动登录
 */
+ (void)hxksAutoLoginSuccess:(void (^)(NSURLSessionDataTask *task,id response))callBack
                        fail:(void (^)(NSURLSessionDataTask *task,id error))failure;

/**
 用户名和密码登录
 @param userName 用户名
 @param password 密码
 @param success 登录成功回调
 @param fail 登录失败回调
 */
+ (void)hxksLoginWithUserName:(NSString *)userName
                     passWord:(NSString *)password
                      success:(void (^)(NSURLSessionDataTask *task, id response))success
                      failure:(void (^)(NSURLSessionDataTask *task, id err))fail;
/**
  退出登录
 */
+ (void)hxksLogoutSuccess:(void (^)(NSURLSessionDataTask *task,id response))success
                     fail:(void (^)(NSURLSessionDataTask *task,id error))failure;
/**
  进入首页
 */
+ (void)jumpToMainPage;

@end
