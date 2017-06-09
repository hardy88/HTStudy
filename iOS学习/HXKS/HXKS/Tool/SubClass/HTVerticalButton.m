//
//  HTCustomButton.m
//  HTHXBB
//
//  Created by hardy on 2017/3/23.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTVerticalButton.h"

@implementation HTVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY , titleW, titleH);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = CGRectGetWidth(contentRect);
    
    CGFloat imageH = contentRect.size.height * 0.6;
    
    CGFloat balance = MIN(imageW, imageH);
    
    CGFloat x = (imageW - balance)/2;

    return CGRectMake(x >0 ? x : 0, x > 0 ? 2 : -x, balance, balance);
}

@end
