//
//  HTRequestService.m
//  HTRequestService
//
//  Created by hardy on 2017/9/28.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "HTRequestService.h"

@interface HTRequestService ()<NSURLSessionDelegate>

@end

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
    
    // 设置请求数据的content-type
    //  [reuqest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
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
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
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
#pragma mark -- NSURLSessionDelegate
// 客户端处理，是否需要安装证书
// NSURLAuthenticationChallenge 中的protectionSpace对象存放了服务器返回的证书信息
// 如何处理证书?(使用、忽略、拒绝。。)
/*
 
 NSURLSessionAuthChallengeUseCredential 使用证书
 NSURLSessionAuthChallengePerformDefaultHandling 忽略证书 默认的做法
 NSURLSessionAuthChallengeCancelAuthenticationChallenge 取消请求,忽略证书
 NSURLSessionAuthChallengeRejectProtectionSpace 拒绝,忽略证书
 
 */
// 只有HTTPS请求才会回调这个函数
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    NSLog(@"didReceiveChallenge ");
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) // 服务器信任证书
    {
        NSLog(@"server ---------");
        NSString *host = challenge.protectionSpace.host;
        NSLog(@"%@", host);
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
    else if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate]) // 输入密码的证书，校验自己的证书
    {
        //客户端证书认证
        //TODO:设置客户端证书认证
        // load cert
        NSLog(@"client");
        NSString *path = [[NSBundle mainBundle]pathForResource:@"client"ofType:@"p12"];
        NSData *p12data = [NSData dataWithContentsOfFile:path];
        CFDataRef inP12data = (__bridge CFDataRef)p12data;
        SecIdentityRef myIdentity;
        OSStatus status = [self extractIdentity:inP12data toIdentity:&myIdentity];
        if (status != 0)
        {
            return;
        }
        SecCertificateRef myCertificate;
        SecIdentityCopyCertificate(myIdentity, &myCertificate);
        const void *certs[] = { myCertificate };
        CFArrayRef certsArray =CFArrayCreate(NULL, certs,1,NULL);
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity certificates:(__bridge NSArray*)certsArray persistence:NSURLCredentialPersistencePermanent];
        //         网上很多错误代码如上，正确的为：
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

- (OSStatus)extractIdentity:(CFDataRef)inP12Data toIdentity:(SecIdentityRef*)identity {
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("123456");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    if (securityError == 0)
    {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    else
    {
        NSLog(@"clinet.p12 error!");
    }
    
    if (options)
    {
        CFRelease(options);
    }
    return securityError;
}

@end
