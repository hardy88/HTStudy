//
//  HTNetwork.h
//  HTHXBB
//
//  Created by hardy on 2017/3/1.
//  Copyright © 2017年 hardy. All rights reserved.

/*
 * 网络请求工具
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTNetwork : NSObject


+ (instancetype)manger;

/*!
 *  POST请求
 *
 *  @param URLString  请求的baseUrl
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+(void)POST:(NSString*)URLString
 parameters:(id)parameters
    success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/*!
 *  GET请求
 *
 *  @param URLString  请求的baseUrl
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+ (void)GET:(NSString*)URLString
 parameters:(id)parameters
    success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
/*!
 *  DELE请求
 *
 *  @param URLString  请求的baseUrl
 *  @param parameters 请求参数
 *  @param success    请求成功后的回调
 *  @param failure    请求失败后的回调
 */
+(void)DELE:(NSString*)URLString
 parameters:(id)parameters
    success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;

/*!
 *  Post请求上传图片
 *
 *  @param image   上传的图片
 *  @param url     请求的baseUrl
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)UPLoadImage:(UIImage *)image
           pathUrl:(NSString*)url
        parameters:(id)parameters
           success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
           failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;




+ (void)UpLoadImages:(NSArray<UIImage*> *)images
           imageName:(NSArray<NSString*> *)imageNames
             pathUrl:(NSString *)url
          parameters:(id)parameters
           imageType:(NSString *)imageType
            mimeType:(NSString *)mimeType
             success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)UpLoadFile:(NSArray<NSString*>*)filePath
               url:(NSString*)url
        parameters:(id)parameters
          fileType:(NSString*)fileType
          mimeType:(NSString*)mimeType
           success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
