//
//  UILabel+AutoFrame.h
//  HTHXBB
//
//  Created by hardy on 2017/3/9.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoFrame)


/**
 已知label的text内容时，直接自动计算宽和高

 @param x label的X坐标
 @param y label的Y坐标
 @param text label的text值
 @return （UILabel*）UILabel实例对象
 */
- (instancetype)initWithXFrame:(CGFloat)x
                     andYFrame:(CGFloat)y
                         title:(NSString*)text;

/**
 根据text内容获取text的宽和高

 @param text lable的text内容
 @param font lable字体大小
 @param maxSize 预计的宽高
 @return  （CGSize） 实际的宽高
 */
- (CGSize)getCgsizeWithTitle:(NSString*)text
                    textFont:(CGFloat)font
                   maxCgsize:(CGSize)maxSize;

@end
