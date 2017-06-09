//
//  VideoPlayer.h
//  AVPlayer
//
//  Created by ClaudeLi on 16/4/13.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  手势类型
 */
typedef NS_ENUM(NSInteger, TouchPlayerViewMode) {
    /**
     *  轻触
     */
    TouchPlayerViewModeNone,
    /**
     *  横滑（快进&快退）
     */
    TouchPlayerViewModeHorizontal,
    /**
     * 竖滑（音量）
     **/
    TouchPlayerViewModeVerticalVolume,
    /**
     *竖滑（亮度）
     **/
    TouchPlayerViewModeVerticalBrightness,
    /**
     *  未知
     */
    TouchPlayerViewModeUnknow,
};

@protocol VideoPlayerDelegate <NSObject>

- (void)playProgressInfo:(float)playTime;

@end

@interface VideoPlayer : UIView
{
    TouchPlayerViewMode _touchMode;
}

//标题设置
@property (strong, nonatomic) UILabel *tittleL;

//返回按钮
@property (strong, nonatomic) UIButton *backBtn;
/**
 *  AVPlayer播放器
 */
@property (nonatomic, strong) AVPlayer *player;
/**
 *  播放状态，YES为正在播放，NO为暂停
 */
@property (nonatomic, assign) BOOL isPlaying;
/**
 *  是否横屏，默认NO -> 竖屏
 */
@property (nonatomic, assign) BOOL isLandscape;
/**
 *  是否锁定屏幕
 */
@property (nonatomic, assign) BOOL isLockScreen;

//其它属性
@property (strong, nonatomic) UIView *view;
/**
 *  _playerLayer所在的View
 */
@property (strong, nonatomic) UIView *playerView;

@property (strong, nonatomic) UIView *backGroundV;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIButton *lockBtn; //锁屏按钮

@property (strong, nonatomic) UIView *downView;
@property (strong, nonatomic) UILabel *videoInfoL; //视频消息标签
@property (strong, nonatomic) UIButton *playBtn; //播放按钮
@property (strong, nonatomic) UIButton *rotateBtn; //转屏按钮
@property (strong, nonatomic) UILabel *currentTimeLabel;
@property (strong, nonatomic) UILabel *totalTimeLabel;
@property (strong, nonatomic) UISlider *playProgress; //播放进度
@property (strong, nonatomic) UIProgressView *bufferProgress; //缓存进度

@property (assign,nonatomic) CGRect frameOfPortrait;

/**
 *  快进/快退
 */
@property (strong, nonatomic)  UIView *speedView;
@property (strong, nonatomic)  UIImageView *speedImage;
@property (strong, nonatomic)  UILabel *speedLabel;

//屏幕亮度，这里传入初始化屏幕亮度，退出播放后还原亮度
@property (nonatomic) CGFloat  screenLight;
//视频播放界面的亮度，任意调节
@property (nonatomic) CGFloat currentScreenLight;

@property (nonatomic, assign) id<VideoPlayerDelegate> delegate;



/**
 *  传入视频地址
 *
 *  @param string 视频url
 */
- (void)updatePlayerWith:(NSURL *)url;

/**
 *  移除通知&KVO
 */
- (void)removeObserverAndNotification;

/**
 *  横屏Layout
 */
- (void)setlandscapeLayout;

/**
 *  竖屏Layout
 */
- (void)setPortraitLayout;

/**
 *切换横竖屏
 */
- (void)rotatingAction:(id)sender;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;

@end
