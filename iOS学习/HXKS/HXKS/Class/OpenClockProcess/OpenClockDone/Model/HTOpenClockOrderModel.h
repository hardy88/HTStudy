//
//  HTOpenClockOrderModel.h
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 完成开锁/开锁失败  --> 订单信息
 */


#import "HTBaseModel.h"

@interface HTOpenClockOrderModel : HTBaseModel

// 申请人
@property (nonatomic, copy) NSString *applyer;
// 联系方式
@property (nonatomic, copy) NSString *telStr;
// 地址
@property (nonatomic, copy) NSString *addStr;
// 有无反锁 YES-有反锁 NO 无反锁
@property(nonatomic)BOOL hsaLock;
// 锁芯类型 0-A类  1 - B类 2 - C类
@property(nonatomic,strong)NSNumber *lockType;
// 完成时间
@property (nonatomic, copy) NSString *timeStr;
@end
