//
//  HTQRCodeCreater.h
//  HTQRCode
//
//  Created by hardy on 2017/5/3.
//  Copyright © 2017年 胡海涛. All rights reserved.



/*
 * 正方形二维码生成器
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTQRCodeCreater : NSObject


/**
 功能：生成二维码图片

 @param url 二维码URL
 @param QRSize 二维码大小（正方形的边长）
 @param logo 二维码中间的Logo图片
 @param logoSize Logo图片大小(正方形logo图片的边长)
 @return （UIImage*）二维码图片
 */
- (UIImage*)createQRCodeWithUrlString:(NSString*)url
                           qRCodeSize:(CGFloat)QRSize
                           centerLogo:(UIImage*)logo
                             logoSize:(CGFloat)logoSize;

@end
