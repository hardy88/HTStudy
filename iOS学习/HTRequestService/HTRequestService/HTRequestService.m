//
//  HTRequestService.m
//  HTRequestService
//
//  Created by hardy on 2017/9/28.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "HTRequestService.h"

@implementation HTRequestService

// POST
+ (void)requestPOSTURL:(NSString *)urlStr
                params:(NSMutableDictionary *)params
           complection:(void (^) (id response))succ
                 error:(void (^) (NSError *err, id errMsg))fail
{
     [HTRequestService requestURL:urlStr httpMethod:@"GET" params:params complection:succ error:fail];
}
// GET请求
+ (void)requestGETURL:(NSString *)urlStr
               params:(NSMutableDictionary *)params
          complection:(void (^) (id response))succ
                error:(void (^) (NSError *err, id errMsg))fail
{
    [HTRequestService requestURL:urlStr httpMethod:@"POST" params:params complection:succ error:fail];
}
// 通用请求
+ (void)requestURL:(NSString *)urlStr
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
       complection:(void (^) (id response))succ
             error:(void (^) (NSError *err, id errMsg))fail
{
    // 可以在此处拼接公共url
    NSString *strUrl = [NSString stringWithFormat:@"%@",urlStr];
    // 将URL中的空白全部去掉，防止url前后有空白
    NSString *urlPath = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *url = [NSURL URLWithString:urlPath];
    
    // 构造request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.timeoutInterval = 30;
    NSString *methodUpperCase = [method uppercaseString];
    // 参数拼接
    NSMutableString *paramsString = [[NSMutableString alloc] init];
   //  取出参数中所有的key值
    NSArray *allKeysFromDic = params.allKeys;
    for (int i =0 ; i < params.count; i++)
    {
        NSString *key = allKeysFromDic[i];
        NSString *value = params[key];
        
        [paramsString appendFormat:@"%@=%@",key,value];
        // 每个关键字之间都用&隔开
        if (i < params.count - 1)
        {
            [paramsString appendString:@"&"];
        }
    }
    
    if ([methodUpperCase isEqualToString:@"GET"]) // get请求就只有URL
    {
        // GET请求需要拼接
        NSString *separe = url.query ? @"&" : @"";
        NSString *paramsURL = [NSString stringWithFormat:@"%@%@%@",urlPath,separe,paramsString];
        request.URL = [NSURL URLWithString:paramsURL];
        request.HTTPMethod = @"GET";
    }
    else if ([methodUpperCase isEqualToString:@"POST"]) // POST请求就需要设置请求正文
    {
        NSData *bodyData = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
        request.URL = url;
        request.HTTPBody = bodyData;
        request.HTTPMethod = @"POST";
    }
    else // 暂时没有考虑DELETE PUT等其他方式
    {
        return;
    }
    
    // NSURLSessionConfiguration 设置请求超时时间， 请求头等信息
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 设置请求超时为30秒钟
    configuration.timeoutIntervalForRequest = 30;
    // 设置在流量情况下是否继续请求
    configuration.allowsCellularAccess = YES;
    // 设置请求的header
    configuration.HTTPAdditionalHeaders = @{@"Accept": @"application/json,text/html,text/plain",
                                            @"Accept-Language": @"en"};
    // 创建NSURLSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 发送Request
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error)
        {
            fail(error,@"没有网络");
            return;
        }
        NSError *err  = nil;
        
        NSHTTPURLResponse *http = (NSHTTPURLResponse*)response;
        NSLog(@"%@",http.MIMEType);
        /*
         1、 服务端需要返回一段普通文本给客户端，Content-Type="text/plain"
         2 、服务端需要返回一段HTML代码给客户端 ，Content-Type="text/html"
         3 、服务端需要返回一段XML代码给客户端 ，Content-Type="text/xml"
         4 、服务端需要返回一段javascript代码给客户端，text/javascript
         5 、服务端需要返回一段json串给客户端，application/Json
         */
        if ([http.MIMEType isEqualToString:@"text/html"])
        {
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            succ(html);
        }
        else
        {
            id res =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:&err];
            if (err)
            {
                fail(err, @"数据解析错误");
                return;
            }
            succ(res);
        }
    }];
    [task resume];
}

@end
