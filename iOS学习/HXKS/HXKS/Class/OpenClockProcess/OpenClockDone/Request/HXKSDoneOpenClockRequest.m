//
//  HXKSDoneOpenClockRequest.m
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSDoneOpenClockRequest.h"

@implementation HXKSDoneOpenClockRequest

+ (void)hxksDoneOpenClockRequest:(NSString *)orderId
                        imageInfo:(NSMutableDictionary *)imgDic
                         success:(void (^) (NSURLSessionDataTask *task, id response))success
                         failure:(void (^) (NSURLSessionDataTask *task, id errMsg))fail
{
    
    NSMutableDictionary *orderIdDic = [[NSMutableDictionary alloc] init];
    [orderIdDic setValue:orderId forKey:@"id"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:orderIdDic forKey:@"order"];
    [dic setObject:imgDic forKey:@"arrLockImg"];
    
    [HTNetwork POST:HXKS_ORDER_DONEORDER_URL parameters:dic success:success failure:fail];
}

@end
