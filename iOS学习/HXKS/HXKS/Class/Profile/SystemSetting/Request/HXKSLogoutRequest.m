//
//  HXKSLogoutRequest.m
//  HXKS
//
//  Created by hardy on 2017/8/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSLogoutRequest.h"
#import "HTNetwork.h"
#import "HXKSManager.h"

@implementation HXKSLogoutRequest

+ (void)hxksLogoutRequest:(id)parameters
                  success:(void (^)(NSURLSessionDataTask *task,id response))success
                  failure:(void (^)(NSURLSessionDataTask *task,id err))fail
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    HXKSManager *manager = [HXKSManager manager];
    if (manager.loginSuccess)
    {
       
        [dic setValue: manager.userInfo.userId forKey:@"yhid"];
        [dic setValue:[NSString stringWithFormat:@"%@",manager.userInfo.jd] forKey:@"jd"];
        [dic setValue:[NSString stringWithFormat:@"%@",manager.userInfo.wd] forKey:@"wd"];
        [dic setValue:manager.userInfo.ipadress forKey:@"ipaddress"];
        [dic setValue:manager.userInfo.dlsblx forKey:@"dlsblx"];
        
        [HTNetwork POST:HXKS_LOGOUTURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            if ([dic[@"code"] isEqual:@(0)])
            {
                success(task,responseObject);
            }
            else
            {
                fail(task,dic[@"msg"]);
            }
            
        } failure:^(NSURLSessionDataTask *task, id error) {
            fail(task,error);
        }];
    }
}

@end
