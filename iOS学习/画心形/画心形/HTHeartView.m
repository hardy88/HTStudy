//
//  HTHeartView.m
//  画心形
//
//  Created by hardy on 16/5/19.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import "HTHeartView.h"
#define SPACE 4

@implementation HTHeartView



-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat  radius =MIN((self.frame.size.width - 2*SPACE)/ 4, (self.frame.size.height - 2*SPACE)/ 4);
    
    UIBezierPath *path  =[UIBezierPath bezierPathWithArcCenter:CGPointMake(radius+SPACE, radius+SPACE) radius:radius startAngle:M_PI endAngle:0 clockwise:YES];
    [ path addArcWithCenter:CGPointMake(3*radius + SPACE,radius + SPACE) radius:radius  startAngle:M_PI endAngle:0 clockwise:YES];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height -2*SPACE) controlPoint:CGPointMake( self.frame.size.width - SPACE, self.frame.size.height *0.6)];
    [path addQuadCurveToPoint:CGPointMake(SPACE, radius + SPACE ) controlPoint:CGPointMake(SPACE, self.frame.size.height *0.6)];
    [path setLineCapStyle:kCGLineCapRound];

    [path setLineWidth:1];
    [[UIColor redColor] set];
    
    [path stroke];
    [path addClip];
}


@end
