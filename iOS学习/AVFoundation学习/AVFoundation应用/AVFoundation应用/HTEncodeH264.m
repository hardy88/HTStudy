//
//  HTEncodeH264.m
//  AVFoundation应用
//
//  Created by hardy on 2017/9/8.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTEncodeH264.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoToolBox/VideoToolBox.h"

@interface HTEncodeH264 ()
{
    NSData *sps;
    NSData *pps;
}

@property (nonatomic,assign) VTCompressionSessionRef  compressSession;
// 帧数
@property(nonatomic,assign)int countFrameNum;

@end

@implementation HTEncodeH264

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _countFrameNum = 0;
        sps = nil;
        pps = nil;
    }
    return self;
}
-(void) prepareEncodeH264WithWidth:(int)width andHeight:(int)height
{
    
    // 创建session， 设置编码完成后的回调didFinishCompressH264CallBack
    //  compression  压缩文件，即编码
    OSStatus status = VTCompressionSessionCreate(NULL, width, height, kCMVideoCodecType_H264, NULL, NULL, NULL, didFinishCompressH264CallBack, (__bridge void *)self, &_compressSession);
    
    if (status != 0 )
    {
        NSLog(@"创建Session失败");
        return;
    }
    
    // 设置session 属性, 设置实时编码输出
    VTSessionSetProperty(_compressSession, kVTCompressionPropertyKey_RealTime, kCFBooleanTrue);
    VTSessionSetProperty(_compressSession, kVTCompressionPropertyKey_ProfileLevel, kVTProfileLevel_H264_Main_AutoLevel);
    
    // 设置关键帧间隔
    int frameInterval = 10;
    CFNumberRef frameIntervalRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &frameInterval);
    VTSessionSetProperty(_compressSession, kVTCompressionPropertyKey_MaxKeyFrameIntervalDuration, frameIntervalRef);
    
    // 设置期望帧率
    int fps = 10;
    CFNumberRef  fpsRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &fps);
    VTSessionSetProperty(_compressSession, kVTCompressionPropertyKey_ExpectedFrameRate, fpsRef);
    
    // 设置码率上限，bps
    int bitRate = width * height * 3 * 4 * 8;
    CFNumberRef bitRateRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRate);
    VTSessionSetProperty(_compressSession, kVTCompressionPropertyKey_AverageBitRate, bitRateRef);
    
    // 设置码率均值 byte
    int bitRateLimit = width * height * 3 * 4;
    CFNumberRef bitRateLimitRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRateLimit);
    VTSessionSetProperty(_compressSession, kVTCompressionPropertyKey_DataRateLimits, bitRateLimitRef);
    
    // 准备开始编码
    VTCompressionSessionPrepareToEncodeFrames(_compressSession);
    
}
- (void)startEncodeh264:(CMSampleBufferRef)sampleBuffer
{
    if (sampleBuffer)
    {
        _countFrameNum ++;
        // 提取CVImageBufferRef
        CVImageBufferRef imageBuff = (CVImageBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
        // 设置时间基
        CMTime timeStamp = CMTimeMake(_countFrameNum, 1000);
        
        VTEncodeInfoFlags flags;
        
        // 开始编码
        OSStatus code = VTCompressionSessionEncodeFrame(_compressSession,
                                                        imageBuff,
                                                        timeStamp,
                                                        kCMTimeInvalid,
                                                        NULL, NULL, &flags);
        if (code != noErr)
        {
            NSLog(@"编码错误");
            // 结束编码
            VTCompressionSessionInvalidate(_compressSession);
            CFRelease(_compressSession);
            _compressSession = NULL;
            return;
        }
        NSLog(@"--->H264编码成功!， 编码成功后会自动回调didFinishCompressH264CallBack函数");
        
    }
}
#pragma mark -----   视频完成编码的回调
void didFinishCompressH264CallBack(void *outputCallbackRefCon, void *sourceFrameRefCon, OSStatus status, VTEncodeInfoFlags infoFlags,  CMSampleBufferRef sampleBuffer)
{
    if (status != 0)
    {
        return;
    }
    
    if (!CMSampleBufferDataIsReady(sampleBuffer))
    {
        NSLog(@"编码帧数据还没有OK!");
        return;
    }
    
    HTEncodeH264 *encoder = (__bridge HTEncodeH264*)outputCallbackRefCon;
    // 确认帧数据中是否包含了关键帧
    // 关键帧中不包含 kCMSampleAttachmentKey_NotSync  这个key值
    bool isKeyFrame = !CFDictionaryContainsKey( CFArrayGetValueAtIndex(CMSampleBufferGetSampleAttachmentsArray(sampleBuffer, true), 0), kCMSampleAttachmentKey_NotSync);
    if (!isKeyFrame)   // 关键帧就要取 SPS 和 PPS
    {
        CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
        size_t spsLen, count;
        const uint8_t *spsBytes;
        OSStatus code = CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 0, &spsBytes, &spsLen, &count, 0);
        if (noErr == code) // 找到 SPS
        {
            size_t ppsLen, ppsCount;
            const uint8_t *ppsBytes;
            OSStatus ppsErrCode =  CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 1, &ppsBytes, &ppsLen, &ppsCount, 0 );
            if (noErr == ppsErrCode) // 找到PPS
            {
                encoder -> sps = [NSData dataWithBytes:spsBytes length:spsLen];
                encoder -> pps = [NSData dataWithBytes:ppsBytes length:ppsLen];
                
                if (encoder->_delegate && [encoder->_delegate respondsToSelector:@selector(HTEncodeH264:sps:pps:)])
                {
                    [encoder->_delegate HTEncodeH264:encoder sps:encoder->sps pps:encoder->pps];
                }
                
            }
        }
        
    }
}

@end
