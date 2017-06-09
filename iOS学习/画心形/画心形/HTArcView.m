//
//  HTArcView.m
//  画心形
//
//  Created by hardy on 16/5/19.
//  Copyright © 2016年 Hardy Hu. All rights reserved.


#import "HTArcView.h"
#import "HTHeartView.h"

@implementation HTArcView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path  = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer =[[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}


@end
