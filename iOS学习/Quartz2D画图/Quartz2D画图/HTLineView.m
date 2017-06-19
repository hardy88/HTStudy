//
//  HTLineView.m
//  Quartz2D画图
//
//  Created by hardy on 2017/6/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTLineView.h"

@implementation HTLineView


- (void)drawRect:(CGRect)rect
{
    // 1. 获取图像上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 2. 设置起点
    CGContextMoveToPoint(ctx, 10, 100);
    // 3. 画直线
    CGContextAddLineToPoint(ctx, 100, 100);
    // 4. 设置线条颜色 红色
    CGContextSetRGBStrokeColor(ctx, 1.0, 0, 0, 1.0);
    // 5. 设置线条宽度
    CGContextSetLineWidth(ctx, 10);
    // 6. 设置线条的起点和终点的样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // 7. 设置线条的转角的样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    // 8. 开始绘制
    CGContextStrokePath(ctx);
    // 9. 结束绘图
//    CGContextClosePath(ctx);
}


@end
