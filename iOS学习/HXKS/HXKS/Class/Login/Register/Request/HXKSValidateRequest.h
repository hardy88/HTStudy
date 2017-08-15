//
//  HXKSValidateRequest.h
//  HXKS
//
//  Created by hardy on 2017/7/27.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 获取手机验证码
 */


#import <Foundation/Foundation.h>

@interface HXKSValidateRequest : NSObject


+ (void)startValidateRequestWithParameter:(NSString* )phoneStr
                                  success:(void (^) (NSURLSessionDataTask *task,id responseObj))success
                                  failure:(void (^) (NSURLSessionDataTask *task,id err))fail;

@end
