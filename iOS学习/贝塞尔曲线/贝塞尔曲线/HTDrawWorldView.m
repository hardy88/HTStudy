//
//  HTDrawWorkView.m
//  贝塞尔曲线
//
//  Created by hardy on 2017/6/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTDrawWorldView.h"

@implementation HTDrawWorldView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSString *str = @"Quartz 2D是一个二维绘图引擎，同时支持iOS和Mac系统";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //设置文字大小
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    //设置文字颜色
    dict[NSForegroundColorAttributeName] = [UIColor greenColor];
    //设置描边宽度
    dict[NSStrokeWidthAttributeName] = @2;
    //设置描边颜色
    dict[NSStrokeColorAttributeName] = [UIColor blueColor];
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    //设置阴影的便宜量
    shadow.shadowOffset = CGSizeMake(1, 1);
    //设置阴影颜色
    shadow.shadowColor = [UIColor greenColor];
    //设置阴影模糊程序
    shadow.shadowBlurRadius = 1;
    dict[NSShadowAttributeName] = shadow;
    
    /**
     AtPoint:文字所画的位置
     withAttributes:描述文字的属性.
     */
    //不会自动换行
    [str drawAtPoint:CGPointMake(10, 64) withAttributes:dict];
    //会自动换行.
    [str drawInRect:self.bounds withAttributes:dict];
}

@end
