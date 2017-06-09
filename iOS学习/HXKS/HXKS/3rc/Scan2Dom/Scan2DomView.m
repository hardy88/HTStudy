//
//  Scan2Dom.m
//  hxszy
//
//  Created by hardy on 16/6/16.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import "Scan2DomView.h"
#import <AVFoundation/AVFoundation.h>

#define  SC_WIDTH [UIScreen mainScreen].bounds.size.width
#define  SC_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface Scan2DomView ()<AVCaptureMetadataOutputObjectsDelegate>


@property(nonatomic,strong)AVCaptureDevice *device;
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureDeviceInput *input;
@property(nonatomic,strong)AVCaptureMetadataOutput *outPut;
@property(nonatomic,strong)CAShapeLayer *scanLayer;
@property(nonatomic,strong)CAShapeLayer *shadowLayer;
@property(nonatomic,assign)CGRect scanRect;
@property(nonatomic,strong)CAShapeLayer *maskLayer;

@end


@implementation Scan2DomView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 获取摄像设备
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 创建输入流
        NSError *err;
        _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&err];
        _outPut  = [[AVCaptureMetadataOutput alloc] init];
        

        
        [_outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        _session = [[AVCaptureSession alloc] init];
        // 设置采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        // 添加输入输出
        [_session addInput:_input];
        [_session addOutput:_outPut];
        
        // 设置扫描框
        [self setScanRect];
        
        // 设置扫码支持的编码格式
        _outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        
        // 创建会话
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        layer.frame = self.layer.bounds;
        [self.layer insertSublayer:layer atIndex:0];
        
        // 开始捕获
        [_session startRunning];
    }
    return self;
}
/**
 *  二维码扫描数据返回
 */
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count>0)
    {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        if ([self.delegate respondsToSelector: @selector(scanView:codeInfo:)])
        {
            [self.delegate scanView: self codeInfo: metadataObject.stringValue];
            [self removeFromSuperview];
        }
    }
}
-(void)setScanRect
{
    CGFloat size = SC_WIDTH * 0.7;
    CGFloat minY = (SC_HEIGHT - size) * 0.5 / SC_HEIGHT;
    CGFloat maxY = (SC_HEIGHT + size) * 0.5 / SC_HEIGHT;
    
    //  设置扫描区域  值为 0-1之间  是个比例值
    self.outPut.rectOfInterest = CGRectMake(minY, 0.15, maxY, 0.7);
    
    [self.layer addSublayer:self.shadowLayer];
    [self.layer addSublayer:self.scanRectLayer];
}
-(void)start
{
    [self.session startRunning];
}
-(void)stop
{
    [self.session stopRunning];
}
/*!
 *  扫描框
 */
-(CAShapeLayer*)scanRectLayer
{
    if (!_scanLayer)
    {
        CGRect rect = self.scanRect;
        
        _scanLayer = [CAShapeLayer layer];
        _scanLayer.path = [UIBezierPath bezierPathWithRect:rect].CGPath;
        _scanLayer.fillColor = [UIColor clearColor].CGColor;
        _scanLayer.strokeColor = [UIColor blueColor].CGColor;
    }
    return _scanLayer;
}
-(CAShapeLayer*)shadowLayer
{
    if (!_shadowLayer)
    {
        _shadowLayer = [CAShapeLayer layer];
        _shadowLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        _shadowLayer.fillColor = [UIColor colorWithWhite:0.0 alpha:0.75].CGColor;
        _shadowLayer.mask = self.maskLayer;
    }
    return _shadowLayer;
}
#pragma setter getter 懒加载
/*!
 *  扫描范围
 */
-(CGRect)scanRect
{
    if (CGRectEqualToRect(_scanRect, CGRectZero))
    {
        CGRect rect = self.outPut.rectOfInterest;
        CGFloat yOffset = rect.size.width - rect.origin.x;
        CGFloat xOffset = 0.7;
        _scanRect = CGRectMake(rect.origin.y * SC_WIDTH, rect.origin.x * SC_HEIGHT, xOffset * SC_WIDTH, yOffset * SC_HEIGHT);
    }
    return _scanRect;
}
/*!
 *  遮盖层
 */
-(CAShapeLayer*)maskLayer
{
    
    if (!_maskLayer)
    {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer = [self createMaskLayerWithRect:[UIScreen mainScreen].bounds exceptRect:self.scanRect];
        
    }
    return _maskLayer;
}

#pragma mark -- Self Method
/*!
 *  生成空缺部分的layer
 */
-(CAShapeLayer*)createMaskLayerWithRect:(CGRect)rect exceptRect:(CGRect)exceptRect
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    if (!CGRectContainsRect(rect, exceptRect))
    {
        return nil;
    }
    else if (CGRectEqualToRect(rect, CGRectZero))
    {
        maskLayer.path = [UIBezierPath bezierPathWithRect:rect].CGPath;
        return maskLayer;
    }
    CGFloat boundsInitX = CGRectGetMinX(rect);
    CGFloat boundsInitY = CGRectGetMinY(rect);
    CGFloat boundsWidth = CGRectGetWidth(rect);
    CGFloat boundsHeight = CGRectGetHeight(rect);
    
    CGFloat minX = CGRectGetMinX(exceptRect);
    CGFloat maxX = CGRectGetMaxX(exceptRect);
    CGFloat minY = CGRectGetMinY(exceptRect);
    CGFloat maxY = CGRectGetMaxY(exceptRect);
    CGFloat width = CGRectGetWidth(exceptRect);
    
    //
    UIBezierPath * path = [UIBezierPath bezierPathWithRect: CGRectMake(boundsInitX, boundsInitY, minX, boundsHeight)];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, boundsInitY, width, minY)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(maxX, boundsInitY, boundsWidth - maxX, boundsHeight)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, maxY, width, boundsHeight - maxY)]];
    maskLayer.path = path.CGPath;
    return maskLayer;
}
#pragma mark - touch
/**
 *  点击空白处停止扫描
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self stop];
//    [self removeFromSuperview];
}
@end
