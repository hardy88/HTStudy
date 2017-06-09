//
//  HTCustomerInfoModel.h
//  HXKS
//
//  Created by hardy on 2017/5/23.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTBaseModel.h"

@interface HTCustomerInfoModel : HTBaseModel

//  申请人
@property (nonatomic, copy) NSString *applyStr;

// 联系方式
@property (nonatomic, copy) NSString *telStr;

// 地址
@property (nonatomic, copy) NSString *addStr;

// 有无反锁  YES -- 有反锁  NO -- 无反锁
@property(nonatomic)BOOL hasLock;

// 锁芯类型
@property(nonatomic,strong)NSNumber *lockType;

// 距离
@property (nonatomic, copy) NSString *desStr;

// 发布时间
@property (nonatomic, copy) NSString *timeStr;

@end
