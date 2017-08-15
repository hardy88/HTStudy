//
//  HXKSOrderListRequest.h
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 锁匠获取订单列表
 */



#import <Foundation/Foundation.h>

@interface HXKSOrderListRequest : NSObject

+ (void)hxksOrderListRequestSuccess:(void (^) (NSURLSessionDataTask *task, id response))success
                            failuer:(void (^) (NSURLSessionDataTask *task, id errMsg))fail;

@end
