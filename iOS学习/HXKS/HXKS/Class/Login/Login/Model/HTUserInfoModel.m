//
//  HTUserInfoModel.m
//  HTHXBB
//
//  Created by hardy on 2017/3/2.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTUserInfoModel.h"

@implementation HTUserInfoModel


+ (instancetype)shareUserInfoModel
{
    static HTUserInfoModel *model = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        model = [[HTUserInfoModel alloc] init];
    });
    return model;
}

@end
