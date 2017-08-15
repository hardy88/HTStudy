//
//  HXKSRegisterRequest.h
//  HXKS
//
//  Created by hardy on 2017/7/27.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 注册
 */


#import <Foundation/Foundation.h>

@interface HXKSRegisterRequest : NSObject

+ (void)startRegisterRequestWithParameter:(id)parameter
                                  success:(void (^) (id responseObj))success
                                  failure:(void (^) (id err))fail;

@end
