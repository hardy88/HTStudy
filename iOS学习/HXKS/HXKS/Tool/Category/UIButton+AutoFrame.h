//
//  UIButton+AutoFrame.h
//  HXKS
//
//  Created by hardy on 2017/7/21.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AutoFrame)

- (CGSize)getCgsizeWithTitle:(NSString*)text
                    textFont:(CGFloat)font
                   maxCgsize:(CGSize)maxSize;

@end
