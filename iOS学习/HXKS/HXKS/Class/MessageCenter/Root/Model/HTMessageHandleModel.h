//
//  HTMessageHandleModel.h
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*
 * 请您开锁
 */


#import "HTBaseModel.h"

@interface HTMessageHandleModel : HTBaseModel


// 消息发送时间
@property (nonatomic, copy) NSString *messageTime;

// 备注
@property (nonatomic, copy) NSString *bzStr;

// 地址
@property (nonatomic, copy) NSString *addStr;

@end
