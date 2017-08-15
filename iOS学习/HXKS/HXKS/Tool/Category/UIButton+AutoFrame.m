//
//  UIButton+AutoFrame.m
//  HXKS
//
//  Created by hardy on 2017/7/21.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "UIButton+AutoFrame.h"

@implementation UIButton (AutoFrame)

- (CGSize)getCgsizeWithTitle:(NSString*)text
                    textFont:(CGFloat)font
                   maxCgsize:(CGSize)maxSize
{
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],} context:nil].size;
    return size;
}

@end
