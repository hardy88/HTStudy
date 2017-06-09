//
//  LoginRequest.m
//  HTHXBB
//
//  Created by hardy on 2017/3/1.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "LoginRequest.h"
#import "HTNetwork.h"
#import "OpenUDID.h"
#import "HTEncrypt.h"


@implementation LoginRequest

- (void)loginWithUserName:(NSString*)userName
                 password:(NSString*)password
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *md5 = [HTEncrypt toMd5:password];
    
    [dic setValue:userName forKey:@"dlyhm"];
    [dic setValue:md5 forKey:@"dlmm"];
    [dic setValue:[OpenUDID value] forKey:@"sncode"];
    [dic setValue:@"01" forKey:@"dlsblx"];
    
    // 我们传给服务器的参数信息，先转换为json string
    NSString *valueStr = [HTEncrypt objectToJason:dic];
    // 其他加密信息
    NSString *encryptStr = [NSString stringWithFormat:@"%@2DAD1C301E93FB9CE050A8C07B0107F1",@"org.aisino.yh.jk.YhJk@login"];
    NSString *base64Str = [HTEncrypt toBase64:encryptStr withDesKey:@"aisino2016-2020"];
    
    NSMutableDictionary *sentDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [sentDic setValue:@"org.aisino.yh.jk.YhJk@login" forKey:@"key"];
    [sentDic setValue:valueStr forKey:@"value"];
    [sentDic setValue:base64Str forKey:@"login"];
    
    
    [HTNetwork POST:@"http://hxbb.hbhtxx.com:8086/sys-rpc/services/RestfulInterface" parameters:sentDic success:^(NSURLSessionDataTask *task,id responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if (!err)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(loginRequest:success:)])
            {
                [self.delegate loginRequest:self success:dic];
            }
        }
        else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(loginRequest:failure:)])
            {
                [self.delegate loginRequest:self failure:err];
            }
        }
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginRequest:failure:)])
        {
            [self.delegate loginRequest:self failure:error];
        }
    }];

}

+ (void)loginWithUserName:(NSString*)userName
                 password:(NSString*)password
                  success:(void (^)(NSURLSessionDataTask *task,id response))success
                  failure:(void (^)(NSURLSessionDataTask *task,NSError *error))fail
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *md5 = [HTEncrypt toMd5:password];
    
    [dic setValue:userName forKey:@"dlyhm"];
    [dic setValue:md5 forKey:@"dlmm"];
    [dic setValue:[OpenUDID value] forKey:@"sncode"];
    [dic setValue:@"01" forKey:@"dlsblx"];
    
    // 我们传给服务器的参数信息，先转换为json string
    NSString *valueStr = [HTEncrypt objectToJason:dic];
    // 其他加密信息
    NSString *encryptStr = [NSString stringWithFormat:@"%@2DAD1C301E93FB9CE050A8C07B0107F1",@"org.aisino.yh.jk.YhJk@login"];
    NSString *base64Str = [HTEncrypt toBase64:encryptStr withDesKey:@"aisino2016-2020"];
    
    NSMutableDictionary *sentDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [sentDic setValue:@"org.aisino.yh.jk.YhJk@login" forKey:@"key"];
    [sentDic setValue:valueStr forKey:@"value"];
    [sentDic setValue:base64Str forKey:@"login"];
    
    
    [HTNetwork POST:@"http://hxbb.hbhtxx.com:8086/sys-rpc/services/RestfulInterface" parameters:sentDic success:^(NSURLSessionDataTask *task,id responseObject) {
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
            fail(task,err);
        }
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        fail(task,error);
    }];
}

@end
