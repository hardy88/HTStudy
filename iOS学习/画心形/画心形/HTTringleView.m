//
//  HTTringleView.m
//  画心形
//
//  Created by hardy on 2017/6/9.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "HTTringleView.h"

#define NUM 5;

@implementation HTTringleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGSize size = self.bounds.size;
    CGFloat w = size.width/NUM;
    CGFloat  radius = w / 2;
    NSLog(@"%f",size.height);
    CGFloat h = size.height - 49;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, h)];
    [path addLineToPoint:CGPointMake(2*w, h)];
    
    [ path addArcWithCenter:CGPointMake(2*w + w/2 ,h) radius:radius  startAngle:M_PI endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(size.width, h)];
    [path addLineToPoint:CGPointMake(size.width, size.height)];
    [path addLineToPoint:CGPointMake(0, size.height)];
    [path addLineToPoint:CGPointMake(0, h)];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

@end
