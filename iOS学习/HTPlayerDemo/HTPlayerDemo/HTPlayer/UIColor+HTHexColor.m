//
//  UIColor+HTHexColor.m
//  TBPlayer
//
//  Created by hardy on 2017/10/20.
//  Copyright © 2017年 . All rights reserved.
//

#import "UIColor+HTHexColor.h"

@implementation UIColor (HTHexColor)

+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alphaValue];
}

@end
