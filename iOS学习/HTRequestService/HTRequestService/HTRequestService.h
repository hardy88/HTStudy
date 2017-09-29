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

/*
 https原理：
 1,客户端请求服务器，如果是第一次请求，服务器向客户端返回证书
 2，客户端需要处理是否同意安装证书，如果同意安装，以后的所有通信都需要用这个证书来加密。（手机端需要自动处理证书）
 3，服务器拿到数据以后，利用自己的私钥解密数据。（数据只有私钥才能解密）
 */

/*
 如果使用AFN则需要两行代码
 //是否接受无效的证书
 manager.securityPolicy.allowInvalidCertificates= YES;
 //是否匹配域名
 manager.securityPolicy.validatesDomainName = NO;
 
 */

/*
 
 1.NSURLRequestUseProtocolCachePolicy NSURLRequest                  默认的cache policy，使用Protocol协议定义。
 2.NSURLRequestReloadIgnoringCacheData                                        忽略缓存直接从原始地址下载。
 3.NSURLRequestReturnCacheDataDontLoad                                     只使用cache数据，如果不存在cache，请求失败；用于没有建立网络连接离线模式
 4.NSURLRequestReturnCacheDataElseLoad                                     只有在cache中不存在data时才从原始地址下载。
 5.NSURLRequestReloadIgnoringLocalAndRemoteCacheData           忽略本地和远程的缓存数据，直接从原始地址下载，与NSURLRequestReloadIgnoringCacheData类似。
 6.NSURLRequestReloadRevalidatingCacheData                              :验证本地数据与远程数据是否相同，如果不同则下载远程数据，否则使用本地数据

 */

@end
