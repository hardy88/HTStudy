//
//  LoginRequest.h
//  HTHXBB
//
//  Created by hardy on 2017/3/1.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoginRequest;

@protocol htLoginRequestDelegate <NSObject>

@optional
- (void)loginRequest:(LoginRequest*)request success:(id)response;
- (void)loginRequest:(LoginRequest*)request failure:(NSError*)error;

@end

@interface LoginRequest : NSObject

@property(nonatomic,assign)id<htLoginRequestDelegate> delegate;

- (void)loginWithUserName:(NSString*)userName
                 password:(NSString*)password;


+ (void)loginWithUserName:(NSString*)userName
                 password:(NSString*)password
                  success:(void (^)(NSURLSessionDataTask *task,id response))success
                  failure:(void (^)(NSURLSessionDataTask *task,id error))fail;



@end
