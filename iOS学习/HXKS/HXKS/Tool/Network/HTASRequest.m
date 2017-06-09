//
//  HTASRequest.m
//  HTHXBB
//
//  Created by hardy on 2017/3/7.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTASRequest.h"
#import "HTNetwork.h"
#import "HTEncrypt.h"


@implementation HTASRequest

+ (void)POSTEncryptKey:(NSString*)key
            parameters:(id)parameters
               success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [HTASRequest POST:@"http://hxbb.hbhtxx.com:8086/sys-rpc/services/RestfulInterface" encryptKey:key parameters:parameters success:success failure:failure];
}

+ (void)POST:(NSString*)URLString
  encryptKey:(NSString*)key
  parameters:(id)parameters
     success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    // 我们传给服务器的参数信息，先转换为json string
    NSString *valueStr = [HTEncrypt objectToJason:dic];
    // 其他加密信息
    NSString *encryptStr = [NSString stringWithFormat:@"%@2DAD1C301E93FB9CE050A8C07B0107F1",key];
    NSString *base64Str = [HTEncrypt toBase64:encryptStr withDesKey:@"aisino2016-2020"];
    
    NSMutableDictionary *sentDic = [NSMutableDictionary dictionaryWithCapacity:0];
    // 加解密key值
    [sentDic setValue:key forKey:@"key"];
    // 参数（json格式）
    [sentDic setValue:valueStr forKey:@"value"];
    // key值加密
    [sentDic setValue:base64Str forKey:@"login"];
    
    NSLog(@"发送请求参数：%@",sentDic);
    
    [HTNetwork POST:URLString parameters:sentDic success:^(NSURLSessionDataTask *task,id responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if (!err)
        {
            success(task,dic);
        }
        else
        {
            failure(task,err);
        }
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
            failure(task,error);
    }];

}
+ (void)UPLoadImage:(UIImage*)image
          imageName:(NSString*)imageName
            success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:imageName forKey:@"filename"];
    [HTNetwork UpLoadImages:@[image] imageName:@[imageName] pathUrl:@"http://hxbb.hbhtxx.com:8086/sys-fileupload/UploadServlet" parameters:dic imageType:@".jpg" mimeType:@"text/html" success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        result = [result stringByReplacingOccurrencesOfString:@"=" withString:@":"];
        id obj = [HTEncrypt jsonToObject:result];
        success(task,obj);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
    }];
}
@end
