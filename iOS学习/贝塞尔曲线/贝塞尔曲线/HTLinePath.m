//
//  HTLinePath.m
//  贝塞尔曲线
//
//  Created by hardy on 2017/6/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTLinePath.h"

@implementation HTLinePath


- (void)drawRect:(CGRect)rect
{
  
    //1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //上下文的状态（线的粗细、颜色、链接样式等）
    //设置线的粗细
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //2. 绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.1 设置起点
    [path moveToPoint:CGPointMake(50, 250)];
    //2.2 添加一根线到终点
    [path addLineToPoint:CGPointMake(250, 50)];
    
    //画第二条直线（新起点）
    [path moveToPoint:CGPointMake(100, 250)];
    [path addLineToPoint:CGPointMake(250, 100)];
    
    //把上一条线的终点当做起点来画第二条线
    [path addLineToPoint:CGPointMake(250, 250)];
    [[UIColor redColor] setStroke];
    
    
    //3.把绘制的内容添加到上下文中
    // UIBezierPath：UIKit框架   --->   CGPathRef：CoreGraphics框架
    CGContextAddPath(ctx, path.CGPath);
    
    //4.把上下文的内容显示到view上（渲染到view的layer上）渲染的方式有两种Stroke（描边）、Fill（填充）
    CGContextStrokePath(ctx);
}


@end
