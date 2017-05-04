//
//  HTSocket.h
//  CF通讯
//
//  Created by hardy on 16/9/1.
//  Copyright © 2016年 hardy. All rights reserved.
//



/*
 
 HTSocket *manager = [HTSocket manager];
 [manager url:@"192.168.1.181"
 port:@"30000"
 method:@"ht_login"
 message:@"你好，我要登录"
 callBack:^(id response) {
 
 NSLog(@"登录信息：%@",response);
 
 }];
 
 */


#import <Foundation/Foundation.h>

@interface HTSocket : NSObject


/**
 实例化方法

 @return 单例HTSocket对象
 */
+ (instancetype)manager;

/**
 发送请求
 
 @param url 请求URL
 @param port 请求port
 @param method 请求函数
 @param message 请求内容
 @param callback 返回值
 */
- (void)url:(NSString*)url
       port:(NSString*)port
     method:(NSString*)method
    message:(NSString*)message
   callBack:(void(^)(id response))callback;

/**
 发送请求

 @param url 请求URL
 @param method 请求函数
 @param message 请求内容
 @param callback 返回值
 
  不设置端口号，默认端口号为 80
 */
- (void)url:(NSString*)url
     method:(NSString*)method
    message:(NSString*)message
    callBack:(void(^)(id response))callback;



@end
