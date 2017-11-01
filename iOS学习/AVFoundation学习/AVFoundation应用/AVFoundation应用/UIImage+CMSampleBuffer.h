//
//  UIImage+CMSampleBuffer.h
//  AVFoundation应用
//
//  Created by hardy on 2017/10/31.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (CMSampleBuffer)


/**
 CMSampleBufferRef 转为UIImage
 yuv格式图片
 @param sampleBuffer CMSampleBufferRef结构体
 @return UIImage
 */
+ (UIImage *)getImageFromCMSampleBuffer:(CMSampleBufferRef)sampleBuffer;


/**
 CMSampleBufferRef 转为RGB格式的buffer
 yuv->rgb格式图片
 @param sampleBuffer CMSampleBufferRef结构体
 @return uint8_t 数组
 */
+ (UIImage  *)getRgbImageFromCMSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
