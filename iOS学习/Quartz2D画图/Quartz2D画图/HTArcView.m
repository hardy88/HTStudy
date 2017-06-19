//
//  HTArcView.m
//  Quartz2D画图
//
//  Created by hardy on 2017/6/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTArcView.h"

@implementation HTArcView


- (void)drawRect:(CGRect)rect
{
   
    // 画圆弧
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 2.画圆弧
    // x/y 圆心
    // radius 半径
    // startAngle 开始的弧度
    // endAngle 结束的弧度
    // clockwise 画圆弧的方向 (0 顺时针, 1 逆时针)
    CGContextAddArc(ctx, 100, 100, 50, 0, M_PI * 2, 1);
//    CGContextClosePath(ctx);
    
    // 3.设置线条颜色
    [[UIColor redColor] set];
    // 4. 绘图
         CGContextStrokePath(ctx);
//    CGContextFillPath(ctx);
}


@end
