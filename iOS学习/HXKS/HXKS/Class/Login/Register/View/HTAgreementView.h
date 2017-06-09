//
//  HTAgreementView.h
//  HXKS
//
//  Created by hardy on 2017/5/18.
//  Copyright © 2017年 胡海涛. All rights reserved.


/*
 * 已经阅读并同意 View
 */


#import <UIKit/UIKit.h>

@interface HTAgreementView : UIView

- (instancetype _Nullable )initWithFrame:(CGRect)frame andTitle:(NSString *_Nullable)title;

- (void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;

@end
