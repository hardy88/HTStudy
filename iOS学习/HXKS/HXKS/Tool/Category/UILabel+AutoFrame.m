//
//  UILabel+AutoFrame.m
//  HTHXBB
//
//  Created by hardy on 2017/3/9.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "UILabel+AutoFrame.h"

@implementation UILabel (AutoFrame)

- (instancetype)initWithXFrame:(CGFloat)x
                     andYFrame:(CGFloat)y
                         title:(NSString*)text
{
    self = [super init];
    if (self)
    {
        self.font = [UIFont systemFontOfSize:14];
        self.numberOfLines = 0;
        self.text = text;
        // withSize是最大
        CGSize size = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],} context:nil].size;
        self.frame = CGRectMake(x, y, size.width, size.height);
    }
    return self;
}
- (CGSize)getCgsizeWithTitle:(NSString*)text
                    textFont:(CGFloat)font
                   maxCgsize:(CGSize)maxSize
{
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],} context:nil].size;
    return size;
}
@end
