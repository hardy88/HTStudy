//
//  HTUsercenterView.h
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTUsercenterView : UIView

- (instancetype _Nullable )initWithFrame:(CGRect)frame andTitle:(NSString *_Nullable)title;

- (void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;


@end
