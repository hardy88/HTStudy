//
//  ViewController.m
//  AVFoundation应用
//
//  Created by hardy on 2017/9/7.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import "HTVideoCapture.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>
{
    HTVideoCapture *video;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    video = [[HTVideoCapture alloc] initWithSampleBufferDelegate:self];
    
    [video startRunning];
}


#pragma mark -- AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (video.videoConnection == connection)
    {
        NSLog(@"");
        NSLog(@"");
    }
}

@end
