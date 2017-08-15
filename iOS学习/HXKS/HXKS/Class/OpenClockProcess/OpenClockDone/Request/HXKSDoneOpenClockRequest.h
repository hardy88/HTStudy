//
//  HXKSDoneOpenClockRequest.h
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 锁匠确定完成订单
 */


#import <Foundation/Foundation.h>

@interface HXKSDoneOpenClockRequest : NSObject




+ (void)hxksDoneOpenClockRequest:(NSString *)orderId
                        imageInfo:(NSMutableDictionary *)imgDic
                         success:(void (^) (NSURLSessionDataTask *task, id response))success
                         failure:(void (^) (NSURLSessionDataTask *task, id errMsg))fail;


@end
