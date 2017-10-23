//
//  UIColor+HTHexColor.h
//  TBPlayer
//
//  Created by hardy on 2017/10/20.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HTHexColor)

+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

@end
