//
//  HTDecodeH264.m
//  AVFoundation应用
//
//  Created by hardy on 2017/9/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTDecodeH264.h"
#import <VideoToolbox/VideoToolbox.h>


@interface HTDecodeH264()

// H264输入流
@property (nonatomic,strong) NSInputStream  *inputStream;
// 输入流大小
@property(nonatomic,assign) int inputFileSize;
// 设置输入流的最大大小
@property(nonatomic,assign) int inputMaxSize;
//
@property(nonatomic,assign)  uint8_t *inputBuffer;
// 时钟
@property (nonatomic,assign) CADisplayLink *displayLink;
//
@property (nonatomic,assign)  long  packetSize;
//
@property (nonatomic,assign)  uint8_t *packetBuffer;

// ******************************    VideoTool   ***************************** //
@property (nonatomic,assign)  VTDecompressionSessionRef decodeSession;
@property (nonatomic,assign)  CMFormatDescriptionRef decodeFormatDescriptionRef;
@property (nonatomic,assign)  uint8_t *mSPS;
@property (nonatomic,assign)  long mSPSSize;
@property (nonatomic,assign)  uint8_t *mPPS;
@property (nonatomic,assign)  long mPPSSize;

@end

const uint8_t lyStartCode[4] = {0, 0, 0, 1};

@implementation HTDecodeH264

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
- (void) prepareDEcodeH264WithWidth:(int)width andHeight:(int)height
{
    // 默认宽和高是 640 * 480
    _inputFileSize = 0;
    _inputMaxSize = 640 * 480 * 3 * 4;
    _inputBuffer = malloc( _inputMaxSize );
}
- (void) startDecodeH264:(NSString *)bundlePath
{
    _inputStream  = [[NSInputStream alloc] initWithFileAtPath:bundlePath];
    [_inputStream open];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startDecodeH264Data)];
    _displayLink.frameInterval = 2;  // 为什么要设置为2
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
   // 开启刷新
    _displayLink.paused = NO;
}

// 开始解码
- (void) startDecodeH264Data
{
    if ( !_inputStream )  return;
    
    // 读数据包， 这是准备工作
    [self gotoReadPacket];
    
    if (_packetBuffer == NULL || _packetSize == 0)
    {
        // 如果在包中没有读到内容，则关闭输入流，并结束解码
        [_inputStream close];
        _inputStream = nil;
        if (_inputBuffer)
        {
            free(_inputBuffer);
            _inputBuffer = NULL;
        }
        _displayLink.paused = YES;
        return;
    }
    
    // 开始解包， 这才是真正开始解码
    [self gotoDecodeWithPacket];
    
}


#pragma mark  --- 内部方法
- (void) gotoReadPacket
{
    if (_packetSize && _packetBuffer)
    {
        // 置空
        _packetSize = 0;
        free(_packetBuffer);
        _packetBuffer = NULL;
    }
    
    if (_inputFileSize < _inputMaxSize && _inputStream.hasBytesAvailable)
    {
        _inputFileSize += [_inputStream read:(_inputBuffer + _inputFileSize)  maxLength:(_inputMaxSize - _inputFileSize)];
    }
    
    if ( memcmp(_inputBuffer, lyStartCode, 4) == 0 )
    {
        if (_inputFileSize > 4)
        {
            // 除了开始码还有内容
            uint8_t *pStart = _inputBuffer + 4;
            uint8_t *pEnd = _inputBuffer + _inputFileSize;
            
            while (pStart != pEnd)
            {
                // 通过查询 0x00000001来获取一帧的长度
                if ( memcmp(pStart -3, lyStartCode, 4) == 0 )
                {
                    _packetSize = pStart - _inputBuffer - 3;
                    if (_packetBuffer)
                    {
                        free(_packetBuffer);
                        _packetBuffer = NULL;
                    }
                    _packetBuffer = malloc(_packetSize);
                    // 复制packet内容到新的缓冲区
                    memcmp(_packetBuffer, _inputBuffer, _packetSize);
                    // 把缓冲区前移
                    memmove(_inputBuffer, _inputBuffer + _packetSize, _inputFileSize - _packetSize);
                    
                    _inputFileSize -= _packetSize;
                }
                else
                {
                    ++pStart;
                }
            }
         }
      }
}

- (void)gotoDecodeWithPacket
{
    uint32_t nalSize = (uint32_t)(_packetSize - 4);
    uint32_t *pNalSize = (uint32_t *)_packetBuffer;
    *pNalSize = CFSwapInt32HostToBig(nalSize);
    
    // 在buffer的前面填入代表长度的int
    CVPixelBufferRef pixelBuffer = NULL;
    int nalType = _packetBuffer[4] & 0x1F;
    switch (nalType)
    {
        case 0x05:   // NAL type is IDR Frame
        {
            [self videoToolInit];
            pixelBuffer = [self deCodeH264];
        }
            break;
        
        case 0x07:  // NAL type is SPS
        {
            _mSPSSize = _packetSize - 4;
            _mSPS = malloc(_mSPSSize);
            memcpy(_mSPS, _packetBuffer + 4, _mSPSSize);
        }
            break;
            
        case 0x08:  // NAL type is PPS
        {
            _mSPSSize = _packetSize - 4;
            _mPPS = malloc(_mSPSSize);
            memcpy(_mSPS, _packetBuffer + 4, _mSPSSize);
        }
            break;
            
        default:  // NAL type is B/P Frame
        {
            pixelBuffer = [self deCodeH264];
        }
            break;
    }
    if (pixelBuffer)
    {
        // pixelBuffer回调函数 传入OPENGL进行渲染
        
        // 释放pixelBuffer
        CVPixelBufferRelease(pixelBuffer);
    }
}

/****************************** VideoTool方法 ************************************/
#pragma mark --- VideoTool 相关方法
// 解码的回调
void didFinishDecodeH264(void *decompressionOutputRefCon,
                         void *sourceFrameRefCon,
                         OSStatus status,
                         VTDecodeInfoFlags infoFlags,
                         CVImageBufferRef pixelBuffer,
                         CMTime presentationTimeStamp,
                         CMTime presentationDuration)
{
    CVPixelBufferRef *outputPixelBuffer = (CVPixelBufferRef *)sourceFrameRefCon;
    *outputPixelBuffer = CVPixelBufferRetain(pixelBuffer);
}


// 初始化VideoTool
- (void) videoToolInit
{
    if (_decodeSession)  return;
    
    // 创建 session
    const uint8_t * parameterSetPointers[2] = {_mSPS,_mSPS};
    const size_t parameterSetSizes[2] = {_mSPSSize, _mPPSSize};
    ;
     //  创建Session
    OSStatus status = CMVideoFormatDescriptionCreateFromH264ParameterSets(kCFAllocatorDefault, 2, parameterSetPointers, parameterSetSizes, 4, &_decodeFormatDescriptionRef);
    
    // 创建成功
    if (status == noErr)
    {
        CFDictionaryRef attrs = NULL;
        const void *keys[] = {kCVPixelBufferPixelFormatTypeKey};
        
        uint32_t v = kCVPixelFormatType_420YpCbCr8BiPlanarFullRange;
        const void *values[] = {CFNumberCreate(NULL, kCFNumberSInt32Type, &v)};
        attrs = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
        
        // 设置回调
        VTDecompressionOutputCallbackRecord callBackRecord;
        callBackRecord.decompressionOutputCallback = nil;
        callBackRecord.decompressionOutputRefCon = didFinishDecodeH264;
        
        // 开始创建
        status = VTDecompressionSessionCreate(kCFAllocatorDefault, _decodeFormatDescriptionRef, NULL, attrs, &callBackRecord, &_decodeSession);
        CFRelease(attrs);
    }
    else
    {
        NSLog(@"初始化Session失败!!!!!");
    }
}

- (CVPixelBufferRef )deCodeH264
{
    
    CVPixelBufferRef outputPixelBuffer = NULL;
    if (_decodeSession)  // 如果session已经被创建
    {
        CMBlockBufferRef blockBuffer = NULL;
        OSStatus status = CMBlockBufferCreateWithMemoryBlock(kCFAllocatorDefault, (void *)_packetBuffer, _packetSize, kCFAllocatorNull, NULL, 0, _packetSize, 0, &blockBuffer);
        
        if (status == kCMBlockBufferNoErr)
        {
            CMSampleBufferRef sampleBuffer = NULL;
            const size_t sampleSizeArray[] = {_packetSize};
            status = CMSampleBufferCreateReady(kCFAllocatorDefault, blockBuffer, _decodeFormatDescriptionRef, 1, 0, NULL, 1, sampleSizeArray, &sampleBuffer);
            if (status == kCMBlockBufferNoErr && sampleBuffer)
            {
                VTDecodeFrameFlags flags = 0;
                VTDecodeInfoFlags flageOut = 0;
                
                OSStatus decodeStatus = VTDecompressionSessionDecodeFrame(_decodeSession, sampleBuffer, flags, &outputPixelBuffer, &flageOut);
                
                if (decodeStatus == kVTInvalidSessionErr)
                {
                    NSLog(@"invalid session");
                }
                else if (decodeStatus == kVTVideoDecoderBadDataErr)
                {
                     NSLog(@"decode failed");
                }
                else if (decodeStatus != noErr)
                {
                     NSLog(@"decode failed");
                }
                CFRelease(sampleBuffer);
            }
            CFRelease(blockBuffer);
        }
    }
    return outputPixelBuffer;
}
@end
