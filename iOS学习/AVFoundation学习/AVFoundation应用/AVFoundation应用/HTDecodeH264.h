

/**
 VideoTool解码
 功能：将H.264数据解码为CVPixelBufferRef数据
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class HTDecodeH264;

@protocol HTDecodeH264Delegate <NSObject>
@required
/**
 6. 实现代理拿到编码后的数据
 */
- (void)HTEncodeH264:(HTDecodeH264 *)encoder decodeBuffer:(CVPixelBufferRef)pixelBuffer;
@end


@interface HTDecodeH264 : NSObject

- (instancetype) init;

@property (nonatomic,assign)  id<HTDecodeH264Delegate> delegate;
/**
 准备解码H264

 @param width H264的宽
 @param height H264的高
 */
- (void) prepareDEcodeH264WithWidth:(int)width andHeight:(int)height;

/**
 读取工程中的H264文件
 */
- (void) startDecodeH264:(NSString *)bundlePath;
@end
