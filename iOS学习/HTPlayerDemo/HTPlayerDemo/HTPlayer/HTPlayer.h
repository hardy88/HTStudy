#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kHTPlayerStateChangedNotification;
FOUNDATION_EXPORT NSString *const kHTPlayerProgressChangedNotification;
FOUNDATION_EXPORT NSString *const kHTPlayerLoadProgressChangedNotification;

//播放器的几种状态
typedef NS_ENUM(NSInteger, HTPlayerState) {
    HTPlayerStateBuffering = 1,
    HTPlayerStatePlaying   = 2,
    HTPlayerStateStopped   = 3,
    HTPlayerStatePause     = 4
};

@interface HTPlayer : NSObject

@property (nonatomic, readonly) HTPlayerState state;
@property (nonatomic, readonly) CGFloat       loadedProgress;   //缓冲进度
@property (nonatomic, readonly) CGFloat       duration;         //视频总时间
@property (nonatomic, readonly) CGFloat       current;          //当前播放时间
@property (nonatomic, readonly) CGFloat       progress;         //播放进度 0~1
@property (nonatomic          ) BOOL          stopWhenAppDidEnterBackground;// default is YES


+ (instancetype)sharedInstance;

- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView;
- (void)seekToTime:(CGFloat)seconds;

- (void)resume;
- (void)pause;
- (void)stop;

- (void)fullScreen;  //全屏
- (void)halfScreen;   //半屏
@end
