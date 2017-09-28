//
//  HTRequestService.h
//  HTRequestService
//
//  Created by hardy on 2017/9/28.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTRequestService : NSObject

/*******************************   NSUrlSession请求  ************************************/
// 通用请求, 需要自己传请求方法(传@"POST"或@"GET")
+ (void)requestURL:(NSString *)urlStr
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
       complection:(void (^) (id response))succ
             error:(void (^) (NSError *err, id errMsg))fail;

// POST请求
+ (void)requestPOSTURL:(NSString *)urlStr
            params:(NSMutableDictionary *)params
       complection:(void (^) (id response))succ
             error:(void (^) (NSError *err, id errMsg))fail;
// GET请求
+ (void)requestGETURL:(NSString *)urlStr
                params:(NSMutableDictionary *)params
           complection:(void (^) (id response))succ
                 error:(void (^) (NSError *err, id errMsg))fail;
/*******************************   AFNNetWorking请求  ************************************/

/*
 * NSUrlRequest 是个模型，拼接请求参数和方法
   NSUrlSessionDataTask 是发起请求的方法
   NSUrlSession 是个连接NSUrlRequest和NSUrlSessionDataTask的中间件
   NSURLSessionConfiguration 配置请求头信息
   NSURLSessionDataTask 管理数据请求的生命周期
 *
 */


@end
