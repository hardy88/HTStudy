

/*
 VideoTool编码
 功能： 将CMSampleBufferRef编码为H.264数据
 */


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class HTEncodeH264;

@protocol HTEncodeH264Delegate <NSObject>
@required
/**
6. 实现代理拿到编码后的数据
 */
- (void)HTEncodeH264:(HTEncodeH264 *)encoder sps:(NSData *)spsData pps:(NSData *)ppsData;

@end

@interface HTEncodeH264 : NSObject


/**
 1. VideoTool 初始化，主要是对一些参数进行初始赋值

 @return HTEncodeH264 对象
 */
- (instancetype)init;

/**
3. 准备编码H264
 @param width 帧宽
 @param height 帧高
 */
-(void) prepareEncodeH264WithWidth:(int)width andHeight:(int)height;

/**
 4. 开始编码H264

 @param sampleBuffer iOS捕获的帧数据, 图像是未经过编码的
 */
- (void)startEncodeh264:(CMSampleBufferRef)sampleBuffer;


/**
 2. 设置代理
 */
@property(nonatomic,assign)id<HTEncodeH264Delegate> delegate;

@end
