//
//  UIImage+HTImageWithCenterLogo.m
//  HTQRCode
//
//  Created by hardy on 2017/5/3.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "UIImage+HTImageWithCenterLogo.h"

@implementation UIImage (HTImageWithCenterLogo)

- (UIImage*)addCenterlogo:(UIImage*)centerLogo logoPosition:(CGRect)logoRect
{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //四个参数为水印图片的位置
    [centerLogo drawInRect:logoRect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
