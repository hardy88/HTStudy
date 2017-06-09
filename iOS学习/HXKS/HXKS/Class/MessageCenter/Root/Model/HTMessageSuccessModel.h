//
//  HTMessageSuccessModel.h
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*
 * 接单成功 模型
 */


#import "HTBaseModel.h"

@interface HTMessageSuccessModel : HTBaseModel

// 消息发送时间
@property (nonatomic, copy) NSString *messageTime;
// 联系人
@property (nonatomic, copy) NSString *contect;
// 联系地址
@property (nonatomic, copy) NSString *addressStr;
// 联系电话
@property (nonatomic, copy) NSString *telStr;

@end
