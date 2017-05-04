//
//  UIImage+HTImageWithCenterLogo.h
//  HTQRCode
//
//  Created by hardy on 2017/5/3.
//  Copyright © 2017年 胡海涛. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIImage (HTImageWithCenterLogo)


/**
 在一张图片的中间添加水印图片

 @param centerLogo 水印图片
 @param logoRect 水印图片的在图片中的Rect
 @return 带有水印图片的图片
 */
- (UIImage*)addCenterlogo:(UIImage*)centerLogo logoPosition:(CGRect)logoRect;

@end
