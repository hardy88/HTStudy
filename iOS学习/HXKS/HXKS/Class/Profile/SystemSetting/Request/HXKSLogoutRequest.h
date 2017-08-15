//
//  HXKSLogoutRequest.h
//  HXKS
//
//  Created by hardy on 2017/8/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 退出登录
 */


#import <Foundation/Foundation.h>

@interface HXKSLogoutRequest : NSObject


+ (void)hxksLogoutRequest:(id)parameters
                  success:(void (^)(NSURLSessionDataTask *task,id response))success
                  failure:(void (^)(NSURLSessionDataTask *task,id err))fail;

@end
