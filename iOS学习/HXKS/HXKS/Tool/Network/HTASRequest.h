//
//  HTASRequest.h
//  HTHXBB
//
//  Created by hardy on 2017/3/7.
//  Copyright © 2017年 hardy. All rights reserved.
//

/*
 * 公司网络请求接口封装
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTASRequest : NSObject

/**
 POST请求
 @param key <#key description#>
 @param parameters <#parameters description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)POSTEncryptKey:(NSString*)key
            parameters:(id)parameters
               success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 POST请求

 @param URLString <#URLString description#>
 @param key <#key description#>
 @param parameters <#parameters description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)POST:(NSString*)URLString
  encryptKey:(NSString*)key
   parameters:(id)parameters
      success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 POST 上传单张图片

 @param image 图片
 @param imageName 图片名称
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)UPLoadImage:(UIImage*)image
          imageName:(NSString*)imageName
            success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
