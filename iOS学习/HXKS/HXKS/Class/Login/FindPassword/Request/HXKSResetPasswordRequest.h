//
//  HXKSResetPasswordRequest.h
//  HXKS
//
//  Created by hardy on 2017/8/10.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*
 * 忘记密码 / 重设密码
 */


#import <Foundation/Foundation.h>

@interface HXKSResetPasswordRequest : NSObject


/**
 旧密码修改/设置密码

 @param newPassword <#newPassword description#>
 @param oldPassword <#oldPassword description#>
 @param yhid <#yhid description#>
 @param success <#success description#>
 @param fail <#fail description#>
 */
+ (void)hxksResetPassword:(NSString*)newPassword
              oldPassword:(NSString*)oldPassword
                   userId:(NSString*)yhid
                  success:(void (^) (NSURLSessionDataTask *task, id response))success
                  failure:(void (^) (NSURLSessionDataTask *task, id error))fail;


/**
 短信验证码修改/设置密码

 @param newPassword <#newPassword description#>
 @param phonenum <#phonenum description#>
 @param yzm <#yzm description#>
 @param success <#success description#>
 @param fail <#fail description#>
 */
+ (void)hxksResetPassword:(NSString*)newPassword
                 phoneNum:(NSString*)phonenum
               messageNum:(NSString*)yzm
                  success:(void (^) (NSURLSessionDataTask *task, id response))success
                  failure:(void (^) (NSURLSessionDataTask *task, id error))fail;
@end
