//
//  HTAVCaptureTool.h
//  AVFoundation应用
//
//  Created by hardy on 2017/9/7.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*
 * 抓取视频数据
 */

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface HTVideoCapture : NSObject

- (instancetype)initWithSampleBufferDelegate:( UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate> *)delegate;

// 开始视频
- (void)startRunning;

// 结束视频
- (void)stopRunning;

// 视频输出Connection
@property (nonatomic,strong) AVCaptureConnection *videoConnection;

@end


/*
 使用说明: 本类只有视频数据，没有音频数据
 1.  导入
 #import "HTAVCaptureVideo.h"
 #import <AVFoundation/AVFoundation.h>

 2.  遵循AVCaptureVideoDataOutputSampleBufferDelegate代理
 @interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>
 
 3.  设置代理并启动
 - (void)viewDidLoad
 {
     [super viewDidLoad];
 
     video = [[HTVideoCapture alloc] initWithSampleBufferDelegate:self];
 
     [video startRunning];
 }
 4.  实现AVCaptureVideoDataOutputSampleBufferDelegate代理方法，拿到视频帧数据
 #pragma mark -- AVCaptureVideoDataOutputSampleBufferDelegate
 - (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
 {
    if (video.videoConnection == connection)
    {
      NSLog(@"");
      // [video stopRunning];
    }
 }
 
 */
