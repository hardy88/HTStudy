//
//  HTLoginModel.m
//  HTHXBB
//
//  Created by hardy on 2017/3/2.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HXKSUserInfoModel.h"

/*       登录信息      */
@implementation HXKSUserInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.userId = value;
    }
}

@end

