//
//  HTUserInfoModel.h
//  HTHXBB
//
//  Created by hardy on 2017/3/2.
//  Copyright © 2017年 hardy. All rights reserved.
//



/*
 * 登录请求后返回的信息
 */


#import "HTBaseModel.h"

@interface HXKSLoginSuccessModel : HTBaseModel


/**
 O -- 成功   1 -- 失败
 */
@property(nonatomic,strong)NSNumber *code;


/**
 用户信息
 */
@property(nonatomic,strong)NSDictionary *data;


/**
 提示信息
 */
@property (nonatomic, copy) NSString *msg;

@end

