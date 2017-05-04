//
//  HTQRCodeCreater.m
//  HTQRCode
//
//  Created by hardy on 2017/5/3.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTQRCodeCreater.h"
#import "UIImage+HTImageWithCenterLogo.h"

@implementation HTQRCodeCreater

- (UIImage*)createQRCodeWithUrlString:(NSString*)url
                           qRCodeSize:(CGFloat)QRSize
                           centerLogo:(UIImage*)logo
                             logoSize:(CGFloat)logoSize
{
    
    NSParameterAssert(url);
    NSParameterAssert(QRSize);
    
    if ([url isEqualToString:@""])
    {
        NSLog(@"传入的Url为无效url");
        return [[UIImage alloc] init];
    }
    // 生成二维码图片,其默认大小是31*31, 所以二维码会比较模糊
    CIImage * ciImage = [self createQRCodeWithUrlString:url];
    // 调整二维码图像大小
    UIImage * qrImage = [self adjustQRImageSize:ciImage QRSize:QRSize];
    
    // 添加中心Logo
    if (logo && logoSize > 0.0f)
    {
        qrImage = [self addCenterlogo:qrImage centerLogo:logo logoRadia:logoSize];
    }
    return qrImage;
}


- (UIImage*)addCenterlogo:(UIImage*)image centerLogo:(UIImage*)centerLogo logoRadia:(CGFloat)radio
{
    CGFloat logoX = (image.size.width - radio) / 2.0;
    CGFloat logoY = (image.size.height - radio) / 2.0;
    CGFloat logoW = radio;
    CGFloat logoH = radio;
    CGRect Position = CGRectMake(logoX, logoY, logoW, logoH);

    return [image addCenterlogo:centerLogo logoPosition:Position];
}

- (UIImage*)adjustQRImageSize:(CIImage*)ciImage QRSize:(CGFloat)qrSize
{
    // 获取CIImage图片的的Frame
    CGRect ciImageRect = CGRectIntegral(ciImage.extent);
    
    CGFloat scale = MIN(qrSize / CGRectGetWidth(ciImageRect), qrSize / CGRectGetHeight(ciImageRect));
    
    // 创建bitmap
    size_t width = CGRectGetWidth(ciImageRect) * scale;
    size_t height = CGRectGetHeight(ciImageRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:ciImageRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, ciImageRect, bitmapImage);
    
    // 保存Bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

- (CIImage*)createQRCodeWithUrlString:(NSString*)url
{
    // 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜默认属性，因为滤镜有可能保存了上一次的属性
    [filter setDefaults];
    // 将字符串转换成NSData
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    // 设置滤镜,传入Data，
    [filter setValue:data forKey:@"inputMessage"];
    // 生成二维码
    CIImage *qrCode = [filter outputImage];
    return qrCode;
}

@end
