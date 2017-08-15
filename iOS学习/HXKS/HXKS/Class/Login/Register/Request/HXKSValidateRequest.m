//
//  HXKSValidateRequest.m
//  HXKS
//
//  Created by hardy on 2017/7/27.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSValidateRequest.h"
#import "HTNetwork.h"

@implementation HXKSValidateRequest

+ (void)startValidateRequestWithParameter:(NSString* )phoneStr
                                  success:(void (^) (NSURLSessionDataTask *task,id responseObj))success
                                  failure:(void (^) (NSURLSessionDataTask *task,id err))fail
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:phoneStr forKey:@"phonenum"];
    
    [HTNetwork POST:HXKS_FORGETPARRWORD_SENTMESSAGEURL parameters:dic success:^(NSURLSessionDataTask *task,id responseObject) {
         success(task,dic);
    } failure:^(NSURLSessionDataTask *task,id error) {
        fail(task,error);
    }];


}

@end
