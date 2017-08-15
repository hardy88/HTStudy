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

#import "HXKSManager.h"

#import "HXKSUserInfoModel.h"


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
                  failure:(void (^)(NSURLSessionDataTask *task,id error))fail
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:userName forKey:@"acount"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:@"03" forKey:@"dlsblx"];
    [dic setValue:@"192.168.1.181" forKey:@"ipaddress"];
    [dic setValue:@"30.142" forKey:@"jd"];
    [dic setValue:@"114.00" forKey:@"wd"];
    [dic setValue:@"1234" forKey:@"pushid"];
    [HTNetwork POST:HXKS_LOGINURL parameters:dic success:^(NSURLSessionDataTask *task,id responseObject)
     {
         NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
         
         if ([dic[@"code"] isEqual:[NSNumber numberWithInteger:0]])
         {
             NSDictionary *dataDic = dic[@"data"];
             if (dataDic)
             {
                HXKSManager *manager = [HXKSManager manager];
                manager.loginSuccess = YES;
                manager.loginStatus = HXLogin_Success;
                HXKSUserInfoModel *model  = [[HXKSUserInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                manager.userInfo = model;
                success(task,responseObject);
             }
         }
         else
         {
             fail(task,dic[@"msg"]);
         }
       
    } failure:^(NSURLSessionDataTask *task,id error) {
        fail(task,error);
    }];
}

@end
