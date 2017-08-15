//
//  HXKSResetPasswordRequest.m
//  HXKS
//
//  Created by hardy on 2017/8/10.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSResetPasswordRequest.h"
#import "HTNetwork.h"

@implementation HXKSResetPasswordRequest


+ (void)hxksResetPassword:(NSString*)newPassword
              oldPassword:(NSString*)oldPassword
                   userId:(NSString*)yhid
                  success:(void (^) (NSURLSessionDataTask *task, id response))success
                  failure:(void (^) (NSURLSessionDataTask *task, id error))fail
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:newPassword forKey:@"newPass"];
    [dic setValue:oldPassword forKey:@"oldPass"];
    [dic setValue:yhid forKey:@"yhid"];
    
    [HTNetwork POST:HXKS_UPDATEPASSWORD_MODEFYURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, id error) {
        fail(task,error);
    }];
}
+ (void)hxksResetPassword:(NSString*)newPassword
                 phoneNum:(NSString*)phonenum
               messageNum:(NSString*)yzm
                  success:(void (^) (NSURLSessionDataTask *task, id response))success
                  failure:(void (^) (NSURLSessionDataTask *task, id error))fail
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:phonenum forKey:@"phonenum"];
    [dic setValue:newPassword forKey:@"password"];
    [dic setValue:yzm forKey:@"yzm"];
    
    [HTNetwork POST:HXKS_MESSAGEPASSWORD_MODIFYURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, id error) {
        fail(task,error);
    }];
}

@end
