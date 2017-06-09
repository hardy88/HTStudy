//
//  HTCustomerView.h
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*
 * 客户详情
 */

#import <UIKit/UIKit.h>
#import "HTCustomerInfoModel.h"

@interface HTCustomerOrderView : UIView


@property(nonatomic,strong)HTCustomerInfoModel * _Nullable model;

// 关闭按钮
- (void)addCloseTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;

// 抢单按钮
- (void)addQDTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;


@end
