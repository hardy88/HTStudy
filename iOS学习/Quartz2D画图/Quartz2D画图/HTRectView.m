//
//  HTRectView.m
//  Quartz2D画图
//
//  Created by hardy on 2017/6/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTRectView.h"

@implementation HTRectView


- (void)drawRect:(CGRect)rect
{
    // 绘制四边形
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 2.绘制四边形
    CGContextAddRect(ctx, CGRectMake(10, 10, 150, 100));

    [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0] set];
   
    // 3.渲染图形到layer上
    // 填充颜色
    CGContextFillPath(ctx);
    // 路径颜色
    //  CGContextStrokePath(ctx);

}


@end
