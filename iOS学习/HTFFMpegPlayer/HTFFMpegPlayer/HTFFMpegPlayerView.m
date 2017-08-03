//
//  HTFFMpegPlayerView.m
//  HTFFMpegPlayer
//
//  Created by hardy on 2017/6/2.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTFFMpegPlayerView.h"
#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
// 色彩转换、视频场景比例缩放
#include "libswscale/swscale.h"



@interface HTFFMpegPlayerView ()
{
    UIImageView *imgView;
    // 多媒体容器格式的封装、解封装工具
    AVFormatContext *formatContext;
    
    // 文件的详细编码信息，如视频的宽、高、编码类型等
    // 解码器相关信息
    AVCodecContext *codecContext;
    
    // 帧数据
    AVFrame *avFrame;
    
    // 流数据
    AVStream *avStream;
    
    // 音视频帧被放入Packet中
    AVPacket avPacket;
    
    //
    AVPicture avPicture;
    
    // 帧率
    double fps;
    
    // 视频流信息
    int firstVideoStream;
    
    // 视频画面的宽高
    int frameImageWidth;
    int frameImageHeight;
    
    // 每一帧的图片
    UIImage *everyFrameImage;
    
    // 初始化播放器是否成功
    BOOL playInitSuccess;
}
@end

@implementation HTFFMpegPlayerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imgView];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark ---视频播放相关方法
- (void)setVideoPath:(NSString *)videoPath
{
    NSParameterAssert(videoPath);
    if (videoPath && ![videoPath isEqualToString:@""])
    {
        BOOL isSuccess = [self comitFFmpegWithPath:videoPath];
        if (isSuccess)
        {
            NSLog(@"初始化播放器成功");
        }
        else
        {
            NSLog(@"初始化播放器失败");
        }
    }
    else
    {
        NSLog(@"视频播放路径无效！！！");
    }
}

- (UIImage*)frameImage
{
    return everyFrameImage;
}

/**
 播放视频
 */
- (void)play
{
    if (playInitSuccess)
    {
        [self seekTime:0.0];
        //
        [self startPalyWithFPS];
    }
}

/**
 暂停视频
 */
- (void)pause
{
    
}

/**
 停止播放视频
 */
- (void)stop
{
    
}


#pragma mark --- 内部方法

/**
 传入视频文件路径初始化FFMpeg
 @param moviePath 视频文件路径
 @return （BOOL）YES- 初始化成功
 NO -初始化失败
 */
- (BOOL)comitFFmpegWithPath:(NSString*)moviePath
{
    // codec 用于各种类型声音、图像编解码
    AVCodec *pCodec;
    
    // 注册所有解码器
    avcodec_register_all();
    av_register_all();
    avformat_network_init();
    
    const char* filePath = [moviePath UTF8String];
    
    // 打开视频文件, 拉流
    int openVideo = avformat_open_input(&formatContext, filePath, NULL, NULL);
    if (openVideo == 0)
    {
        NSLog(@"打开视频成功");
        // 获取容器信息
        int checkVideo = avformat_find_stream_info(formatContext, NULL);
        if (checkVideo >= 0)
        {
            NSLog(@"打开容器包成功，数据完整");
            // 查找音视频流、字幕流的stream_index， 找到流解码器
            firstVideoStream = av_find_best_stream(formatContext, AVMEDIA_TYPE_VIDEO, -1, -1, &pCodec, 0);
            if (firstVideoStream >= 0)
            {
                NSLog(@"成功找到第一帧数据");
                // 获取视频编解码的上下文指针
                avStream = formatContext ->streams[firstVideoStream];
                // 解码器
                codecContext = avStream ->codec;
                
                // 获取fps
                // AVRational fps是分数来表示的   分子和分母都要大于0
                if (avStream ->avg_frame_rate.den && avStream ->avg_frame_rate.num)
                {
                    fps = av_q2d(avStream ->avg_frame_rate);
                }
                else
                {
                    // 如果没有获取到，则默认为30
                    fps =30;
                }
                
                // 查找解码器
                pCodec = avcodec_find_decoder(codecContext ->codec_id);
                if (pCodec == NULL)
                {
                    NSLog(@"没有找到解码器");
                    return NO;
                }
                
                // 打开解码器
                int codecOpen = avcodec_open2(codecContext, pCodec, NULL);
                if (codecOpen <0)
                {
                    NSLog(@"打开解码器失败");
                    return NO;
                }
                
                avFrame = av_frame_alloc();
                frameImageWidth = codecContext ->width;
                frameImageHeight = codecContext ->height;
                
                playInitSuccess = YES;
                return YES; // 初始化播放器成功
            }
            NSLog(@"没有找到第一帧视频");
            return NO;
        }
        NSLog(@"数据流检查失败，数据不完整");
        return NO;
    }
    NSLog(@"打开视频失败");
    return NO;
}


/**
 跳转到某个时间点处播放
 
 @param seconds 时间点
 */
- (void)seekTime:(double)seconds
{
    AVRational timeBase = formatContext -> streams[firstVideoStream] ->time_base;
    
    int64_t timeFrame = (int64_t)( (double)timeBase.den / timeBase.num * seconds);
    
    // 跳转到0s帧处
    avformat_seek_file(formatContext, firstVideoStream, 0, timeFrame, timeFrame, AVSEEK_FLAG_FRAME);
    
    // 清空buffer状态
    avcodec_flush_buffers(codecContext);
    
}

/**
 开始获取每一帧图片
 */
- (void)startPalyWithFPS
{
    [NSTimer scheduledTimerWithTimeInterval: 1 / fps
                                     target:self
                                   selector:@selector(nextFrameImage:)
                                   userInfo:nil
                                    repeats:YES];
}
- (void)nextFrameImage:(NSTimer *)timer
{
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    if (![self decodeFrame])
    {
        [timer invalidate];
        return;
    }
    imgView.image = [self imageFromFrame];
}

- (BOOL)decodeFrame
{
    int decodeFinished = 0;
    
    while (!decodeFinished && av_read_frame(formatContext, &avPacket) >=0 ) // 读取每一帧数据
    {
        NSLog(@"每帧数据%d",firstVideoStream);
        if (avPacket.stream_index == firstVideoStream)
        {
            // 解码数据
            // 解码一帧视频数据，存储到AVFrame中
            avcodec_decode_video2(codecContext,avFrame, &decodeFinished, &avPacket);
        }
    }
    
    if (decodeFinished == 0 )
    {
        [self releaseResources];
    }
    return  decodeFinished !=0;
}

/**
 获取每帧图像
 @return 每帧图片
 */
- (UIImage *)imageFromFrame
{
    if ( !avFrame ->data[0])
    {
        return nil;
    }
    avpicture_free(&avPicture);
    avpicture_alloc(&avPicture, AV_PIX_FMT_RGB24, frameImageWidth, frameImageHeight);
    
    struct SwsContext *imageCovertContext = sws_getContext(avFrame->width, avFrame ->height, AV_PIX_FMT_YUV420P, frameImageWidth, frameImageHeight, AV_PIX_FMT_RGB24, SWS_FAST_BILINEAR, NULL, NULL, NULL);
    if (imageCovertContext == nil)
    {
        return nil;
    }
    // YUV数据转化为RGB数据
    sws_scale(imageCovertContext, avFrame->data, avFrame->linesize, 0, avFrame->height, avPicture.data, avPicture.linesize);
    sws_freeContext(imageCovertContext);
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CFDataRef data = CFDataCreate(kCFAllocatorDefault,
                                  avPicture.data[0],
                                  avPicture.linesize[0] * frameImageHeight);
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef cgImage = CGImageCreate(frameImageWidth,
                                       frameImageHeight,
                                       8,
                                       24,
                                       avPicture.linesize[0],
                                       colorSpace,
                                       bitmapInfo,
                                       provider,
                                       NULL,
                                       NO,
                                       kCGRenderingIntentDefault);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provider);
    CFRelease(data);
    
    return image;
}


/**
 资源释放
 */
- (void)releaseResources
{
    // 释放RGB
    avpicture_free(&avPicture);
    // 释放frame
    av_packet_unref(&avPacket);
    // 释放YUV frame
    av_free(avFrame);
    // 关闭解码器
    if (codecContext) avcodec_close(codecContext);
    // 关闭文件
    if (formatContext) avformat_close_input(&formatContext);
    avformat_network_deinit();
}


@end
