//
//  HTAVCaptureTool.m
//  AVFoundation应用
//
//  Created by hardy on 2017/9/7.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTVideoCapture.h"

@interface HTVideoCapture ()

// 负责输入和输出设备之间的数据传递
@property (nonatomic,strong)  AVCaptureSession  *captureSession;
// 摄像头输入
@property (nonatomic,strong) AVCaptureDeviceInput *inputDevice;
// 视频输出数据
@property (nonatomic,strong) AVCaptureVideoDataOutput  *videoDataOutput;
// 视频预览层
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
// 处理事物的队列
@property (nonatomic,strong) dispatch_queue_t  sessionQueue;



@end


@implementation HTVideoCapture

- (instancetype)initWithSampleBufferDelegate:( UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate> *)delegate
{
    self = [super init];
    if (self)
    {
        [self configCapture:delegate];
    }
    return self;
}
- (void)configCapture:(UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate> *)vDelegate
{
    
    // 能获取视频的设备有哪些，会返回一个NSArray
    NSArray *camereDevice = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device = nil;
    for (AVCaptureDevice *camere in camereDevice)
    {
        // 如有有后缀摄像头就先显示后置摄像头
        if (camere.position == AVCaptureDevicePositionBack)
        {
            device = camere;
        }
    }
    NSError *err = nil;
    _inputDevice = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&err];
    if (err)
    {
        // 后置摄像头不可用
        NSLog(@"%@",err.description);
        NSLog(@"需要真机！！");
    }
    
    
    _captureSession = [[AVCaptureSession alloc] init];
    // 设置摄像头采集率
    _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    // 添加摄像头输入
    if ([_captureSession canAddInput:_inputDevice])
    {
        [_captureSession addInput: _inputDevice];
    }
    else{
        NSLog(@"需要真机！！");
        return;
    }
    _sessionQueue =  dispatch_queue_create("com.hardy.as", DISPATCH_QUEUE_SERIAL);
    
    // 视频输出数据
    _videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    // 是否丢弃最新的视频帧
    [_videoDataOutput setAlwaysDiscardsLateVideoFrames:NO];
    // 设置视频输出的每张图片格式
    [_videoDataOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    // 输出的回调Delegate
    
    // 此处的queue可以更改为 dispatch_get_mainQueue
    // SampleBufferDelegate代理必须是UIViewController, 要不然不会回调
    [_videoDataOutput setSampleBufferDelegate:vDelegate queue:_sessionQueue];
    
    if ([_captureSession canAddOutput:_videoDataOutput])
    {
        [_captureSession addOutput:_videoDataOutput];
    }
    else
    {
        NSLog(@"需要真机！！");
        return;
    }
    // 设置输出数据类型
    _videoConnection = [_videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    // 设置竖屏数据
    [_videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    // 视频预览层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    self.previewLayer.frame = vDelegate.view.bounds;
    [vDelegate.view.layer addSublayer:self.previewLayer];
    
}

- (void)startRunning
{
    [_captureSession startRunning];
}

// 结束视频
- (void)stopRunning
{
    [_captureSession stopRunning];
    [self.previewLayer removeFromSuperlayer];
}





@end
