//
//  HXKSOrderListRequest.m
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSOrderListRequest.h"


@implementation HXKSOrderListRequest

+ (void)hxksOrderListRequestSuccess:(void (^) (NSURLSessionDataTask *task, id response))success
                            failuer:(void (^) (NSURLSessionDataTask *task, id errMsg))fail
{
    HXKSManager *manager = [HXKSManager manager];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:manager.userInfo.userId forKey:@"yhid"];
    [dic setValue:@"02" forKey:@"yhlx"];
    
    [HTNetwork POST:HXKS_ORDER_ORDERLIST_URL parameters:dic success:success failure:fail];
}

@end
