//
//  HTRectView.m
//  贝塞尔曲线
//
//  Created by hardy on 2017/6/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTRectView.h"

@implementation HTRectView

- (void)drawRect:(CGRect)rect {
    
    //1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //设置颜色
    [[UIColor redColor]set];
    //2.绘制路径
    //画矩形
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    //画圆角矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) cornerRadius:50];
    //3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文渲染到view上
    //描边
    //    CGContextStrokePath(ctx);
    //填充
    CGContextFillPath(ctx);
    
}


@end
