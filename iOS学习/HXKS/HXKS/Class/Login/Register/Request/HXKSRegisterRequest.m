//
//  HXKSRegisterRequest.m
//  HXKS
//
//  Created by hardy on 2017/7/27.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSRegisterRequest.h"


@implementation HXKSRegisterRequest

+ (void)startRegisterRequestWithParameter:(id)parameter
                                  success:(void (^) (id responseObj))success
                                  failure:(void (^) (id err))fail
{
    [HTNetwork POST:HXKS_LOGIN_REGISTERURL parameters:parameter success:^(NSURLSessionDataTask *task,id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        fail(error);
    }];

}

@end
