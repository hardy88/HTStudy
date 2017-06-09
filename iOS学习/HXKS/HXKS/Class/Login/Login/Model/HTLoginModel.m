//
//  HTLoginModel.m
//  HTHXBB
//
//  Created by hardy on 2017/3/2.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTLoginModel.h"

/*       登录信息      */
@implementation HTLoginModel

@end

/*       企业信息      */
@implementation HTLoginQiyeInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.qyId = value;
    }
}

@end


/*       企业信息      */
@implementation HTLoginYonghuInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.yhId = value;
    }
}

@end

/*       用户 mr 信息      */
@implementation HTLoginYhmrdzModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.mrdzId = value;
    }
}

@end
