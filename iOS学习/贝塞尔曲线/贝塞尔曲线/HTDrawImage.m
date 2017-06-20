//
//  HTDrawImage.m
//  贝塞尔曲线
//
//  Created by hardy on 2017/6/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTDrawImage.h"

@implementation HTDrawImage

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //1.加载图片
    UIImage *image = [UIImage imageNamed:@"liuYan.jpeg"];
    
    //绘制出来的图片,是保持原来图片大小
    [image drawAtPoint:CGPointZero];
    //把图片填充到这个rect当中.
    [image drawInRect:rect];
    //添加裁剪区域 .把超区裁剪区域以外都裁剪掉
//    UIRectClip(CGRectMake(0, 0, 50, 50));
    //平铺
//    [image drawAsPatternInRect:self.bounds];
    
//    //快速的画出一个矩形
//    [[UIColor blueColor] set];
//    UIRectFill(CGRectMake(10, 10, 100, 100));
}

@end
