//
//  HTValidateView.h
//  HXKS
//
//  Created by hardy on 2017/5/18.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 验证码倒计时
 */


#import <UIKit/UIKit.h>

@interface HTValidateView : UIView

- (instancetype _Nullable )initWithFrame:(CGRect)frame andTitle:(NSString *_Nullable)title;


- (void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;


@end
