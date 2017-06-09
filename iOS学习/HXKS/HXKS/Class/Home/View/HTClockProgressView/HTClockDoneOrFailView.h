//
//  HTClockDoneOrFailView.h
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*
 * 完成开锁 /  开锁失败
 */



#import <UIKit/UIKit.h>

@interface HTClockDoneOrFailView : UIView

// 完成开锁
- (void)addClockDoneTarget:(nullable id)target action:(SEL _Nullable )action;

// 开锁失败
- (void)addClockDFailTarget:(nullable id)target action:(SEL _Nullable )action;

@end
