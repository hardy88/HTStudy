//
//  HTNetwork.m
//  HTHXBB
//
//  Created by hardy on 2017/3/1.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTNetwork.h"
#import "AFNetworking.h"


@implementation HTNetwork

+ (instancetype)manger
{
    static HTNetwork *manger = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manger = [[HTNetwork alloc] init];
    });
    return manger;
}
+(void)POST:(NSString*)URLString
 parameters:(id)parameters
    success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *task,id error))failure
{
    NSMutableString *baseStr = [NSMutableString stringWithString:POST_BASE_URL];
    [baseStr appendString:URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:baseStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"code"] isEqual:@(0)])
        {
            success(task,responseObject);
        }
        else
        {
            failure(task,dic[@"msg"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
+ (void)GET:(NSString*)URLString
 parameters:(id)parameters
    success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(task,error);
    }];
}
+(void)DELE:(NSString*)URLString
 parameters:(id)parameters
    success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(task,error);
    }];
}

+(void)UPLoadImage:(UIImage *)image
           pathUrl:(NSString*)url
        parameters:(id)parameters
           success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
           failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *uploadImage = image;
        NSData *data = UIImageJPEGRepresentation(uploadImage,1.0);
        [formData appendPartWithFileData:data name:@"file" fileName:@"salesImageBig.jpg" mimeType:@"image/jpeg"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(task,error);
    }];
}

+ (void)UpLoadImages:(NSArray<UIImage*> *)images
           imageName:(NSArray<NSString*> *)imageNames
             pathUrl:(NSString *)url
          parameters:(id)parameters
           imageType:(NSString *)imageType
            mimeType:(NSString *)mimeType
             success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 40;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSInteger i = 0; i < images.count; i++)
        {
            NSData *data = UIImageJPEGRepresentation(images[i], 0.4);
            // name 为文件夹名。可以随便传，
            // filename 为文件名
            [formData appendPartWithFileData:data name:@"filename" fileName:imageNames[i] mimeType:mimeType];
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+ (void)UpLoadFile:(NSArray<NSString*>*)filePath
               url:(NSString*)url
        parameters:(id)parameters
          fileType:(NSString*)fileType
          mimeType:(NSString*)mimeType
           success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // url 是保存图片的路径，
    // parameters 参数可以为nil， 服务器要求上传的参数，以传输userName等字段常见。
    //
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSInteger i = 0; i < filePath.count; i++)
        {
            // name 是服务处理文件字段的关键字，多以@“file”作为关键字
            // fileName 是上传服务器的图片名，可以随便写，但一般是日期命名
            // 图片格式
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *dateStr = [formatter stringFromDate:[NSDate date]];
            // 日期 + 图片格式 = 上传相片名
            NSString *fileName = [NSString stringWithFormat:@"%@.%@",filePath[i],fileType];
            
            [formData appendPartWithFileURL:[NSURL URLWithString:filePath[i]] name:fileName fileName:@"file" mimeType:mimeType error:nil];
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
