//
//  HTFFMpegPlayerView.h
//  HTFFMpegPlayer
//
//  Created by hardy on 2017/6/2.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTFFMpegPlayerView : UIView

/**
 视频的url
 */
@property (nonatomic, copy) NSString *videoPath;


/**
 获取每一帧的图片
 */
@property(nonatomic,strong,readonly) UIImage *frameImage;

/**
 播放视频
 */
- (void)play;

/**
 暂停视频
 */
- (void)pause;

/**
 停止播放视频
 */
- (void)stop;


@end
