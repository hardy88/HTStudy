//
//  HTOrderInfoView.h
//  HXKS
//
//  Created by hardy on 2017/5/23.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 已接单
 */


#import <UIKit/UIKit.h>
#import "HTCustomerInfoModel.h"


@interface HTOrderInfoView : UIView

@property(nonatomic,strong)HTCustomerInfoModel *model;

// 关闭按钮
- (void)addCloseTarget:(nullable id)target action:(SEL _Nullable )action;

@end
