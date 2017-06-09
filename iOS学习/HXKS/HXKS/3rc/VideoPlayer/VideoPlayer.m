//
//  VideoPlayer.m
//  AVPlayer
//
//  Created by ClaudeLi on 16/4/13.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "VideoPlayer.h"
#import "CLRotatingScreen.h"
#import "NSString+time.h"
#import <MediaPlayer/MediaPlayer.h>
#import "JRSoundView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface VideoPlayer ()
{
    BOOL isIntoBackground;
    BOOL isShowToolbar;
    NSTimer *_timer;
    AVPlayerItem *_playerItem;
    AVPlayerLayer *_playerLayer;
    id _playTimeObserver; // 播放进度观察者
    
    UISlider* volumeViewSlider;//音量条
    BOOL isVolumeModel;//区分竖滑区域，分为调节音量或亮度
}
@end

@implementation VideoPlayer
@synthesize topView;
@synthesize playerView;
@synthesize lockBtn;
@synthesize downView;
@synthesize videoInfoL;
@synthesize playBtn;
@synthesize rotateBtn;
@synthesize currentTimeLabel;
@synthesize totalTimeLabel;
@synthesize playProgress;
@synthesize bufferProgress;
@synthesize backBtn;
@synthesize backGroundV;

@synthesize speedView;
@synthesize speedImage;
@synthesize speedLabel;
@synthesize frameOfPortrait;
@synthesize tittleL;
@synthesize screenLight;
@synthesize currentScreenLight;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    //加入亮度调节指示器动画
    [JRSoundView sharedSoundView];
    self = [super initWithFrame:frame];
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
     volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews])
    {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"])
        {
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    frameOfPortrait = frame;
    
    if (self)
    {
        currentScreenLight = screenLight;
        
        self.view = [[UIView alloc] init];
        self.view.backgroundColor = [UIColor blackColor];
        
        playerView = [[UIView alloc] init];
        [self.view addSubview:playerView];
        
        backGroundV = [[UIView alloc] init];
        [self.view addSubview:backGroundV];
    
        topView = [[UIView alloc] init];
        [topView  setBackgroundColor:[UIColor grayColor]];
        [topView setAlpha:0.8];
        
        backBtn = [[UIButton alloc] init];
        [backBtn setImage:[UIImage imageNamed:@"Player_back"] forState:UIControlStateNormal];
        [topView addSubview:backBtn];
        
        tittleL = [[UILabel alloc] init];
        [tittleL setTextColor:[UIColor whiteColor]];
        [tittleL setFont:[UIFont systemFontOfSize:17]];
        [tittleL setTextAlignment:NSTextAlignmentCenter];
        [topView addSubview:tittleL];
        
        lockBtn = [[UIButton alloc] init];
        [lockBtn addTarget:self action:@selector(lockBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [lockBtn setImage:[UIImage imageNamed:@"MoviePlayer_lock"] forState:UIControlStateNormal];
        [lockBtn setHidden:YES];
        [topView addSubview:lockBtn];
        [backGroundV addSubview:topView];
        
        speedView = [[UIView alloc] init];
        speedView.layer.cornerRadius = 4;
        speedView.clipsToBounds = YES;
        [speedView setBackgroundColor:[UIColor grayColor]];
        [speedView setAlpha:0.8];
        
        speedImage = [[UIImageView alloc] init];
        [speedImage setContentMode:UIViewContentModeScaleAspectFit];
        [speedView addSubview:speedImage];
        
        speedLabel = [[UILabel alloc] init];
        [speedLabel setTextColor:[UIColor whiteColor]];
        [speedView addSubview:speedLabel];
        
        [speedView setHidden:YES];
        [backGroundV addSubview:speedView];
        
        playBtn = [[UIButton alloc] init];
        [playBtn setImage:[UIImage imageNamed:@"MoviePlayer_Stop_Big"] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(playOrStopAction:) forControlEvents:UIControlEventTouchUpInside];
        [backGroundV addSubview:playBtn];
        
        
        videoInfoL = [[UILabel alloc] init];
        [videoInfoL setTextColor:[UIColor whiteColor]];
        [videoInfoL setTextAlignment:NSTextAlignmentCenter];
        [videoInfoL setAlpha:0.8];
        [videoInfoL setFont:[UIFont systemFontOfSize:14]];
        
        downView = [[UIView alloc] init];
        [downView setBackgroundColor:[UIColor grayColor]];
        [downView setAlpha:0.8];
        
        currentTimeLabel = [[UILabel alloc] init];
        [currentTimeLabel setTextColor:[UIColor whiteColor]];
        [currentTimeLabel setTextAlignment:NSTextAlignmentCenter];
        [downView addSubview:currentTimeLabel];
        
        totalTimeLabel = [[UILabel alloc] init];
        [totalTimeLabel setTextColor:[UIColor whiteColor]];
        [totalTimeLabel setTextAlignment:NSTextAlignmentCenter];
        [downView addSubview:totalTimeLabel];
        
        
        rotateBtn = [[UIButton alloc] init];
        [rotateBtn addTarget:self action:@selector(rotatingAction:) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:rotateBtn];
        
        bufferProgress = [[UIProgressView alloc] init];
        [bufferProgress setContentMode:UIViewContentModeScaleToFill];
        
        
        playProgress = [[UISlider alloc] init];
        [playProgress setMinimumTrackTintColor:[UIColor blueColor]];
        [playProgress setMaximumTrackTintColor:[UIColor clearColor]];
        [playProgress setContentMode:UIViewContentModeScaleToFill];
        
        [playProgress addTarget:self action:@selector(playerSliderDown:) forControlEvents:UIControlEventTouchDown];
        [playProgress addTarget:self action:@selector(playerSliderInside:) forControlEvents:UIControlEventTouchUpInside];
        [playProgress addTarget:self action:@selector(playerSliderChange:) forControlEvents:UIControlEventValueChanged];
        
        [downView addSubview:bufferProgress];
        [downView addSubview:playProgress];
        
        [backGroundV addSubview:videoInfoL];
        [backGroundV addSubview:downView];
        
        [self addSubview:self.view];
        [self.playProgress setThumbImage:[UIImage imageNamed:@"MoviePlayer_Slider"] forState:UIControlStateNormal];
        [self setPortraitLayout];
        self.player = [[AVPlayer alloc] init];
        self.player.volume = 40.0;
        
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        [self.playerView.layer addSublayer:_playerLayer];
        return self;
    }
    return nil;
}


- (void)setTheFrame:(CGRect)frame
{
    self.bounds = frame;
    [self setFrame:frame];
    [self.view setFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    
    [playerView setFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    playerView.bounds = frame;
  
    [backGroundV setFrame:playerView.frame];
    
    [topView setFrame:CGRectMake(0, 0, CGRectGetWidth(backGroundV.frame), CGRectGetHeight(backGroundV.frame)/6+20)];
    [backBtn setFrame:CGRectMake(0, 20, 50, CGRectGetHeight(topView.frame) - 20)];
    [lockBtn setFrame:CGRectMake(CGRectGetWidth(frame) -50, backBtn.frame.origin.y, 50, CGRectGetHeight(backBtn.frame))];
    [tittleL setFrame:CGRectMake(CGRectGetWidth(backBtn.frame), backBtn.frame.origin.y, CGRectGetWidth(topView.frame) - CGRectGetWidth(lockBtn.frame) - CGRectGetWidth(backBtn.frame) , CGRectGetHeight(backBtn.frame))];
    
    
    [speedView setFrame:CGRectMake(CGRectGetWidth(frame)/2 - 50, CGRectGetHeight(frame)/2 -30, 100, 60)];
    [speedImage setFrame:CGRectMake(0, 2, CGRectGetWidth(speedView.frame), CGRectGetHeight(speedView.frame)/2 -2)];
    [speedLabel setFrame:CGRectMake(0, CGRectGetHeight(speedImage.frame), CGRectGetWidth(speedImage.frame), CGRectGetHeight(speedImage.frame))];
    
    
    [playBtn setFrame:CGRectMake(CGRectGetWidth(frame) - CGRectGetWidth(frame)/4 , CGRectGetHeight(frame)/2, CGRectGetWidth(frame)/4, CGRectGetHeight(frame)/2 - CGRectGetHeight(frame)/6)];
    
   
    
    [downView setFrame:CGRectMake(0, CGRectGetHeight(frame) - CGRectGetHeight(frame)/6, CGRectGetWidth(frame), CGRectGetHeight(frame)/6)];
    
    [currentTimeLabel setFrame:CGRectMake(0, 0, 60, CGRectGetHeight(downView.frame))];
   
    [totalTimeLabel setFrame:CGRectMake(CGRectGetWidth(downView.frame) - 100, 0, 60, CGRectGetHeight(downView.frame))];
    [rotateBtn setFrame:CGRectMake(CGRectGetWidth(downView.frame) -40, 0, 40, CGRectGetHeight(downView.frame))];
    [bufferProgress setFrame:CGRectMake(CGRectGetWidth(currentTimeLabel.frame),CGRectGetHeight(downView.frame)/2-1, totalTimeLabel.frame.origin.x - CGRectGetWidth(currentTimeLabel.frame) , CGRectGetHeight(downView.frame))];
    [playProgress setFrame:CGRectMake(CGRectGetWidth(currentTimeLabel.frame),0, totalTimeLabel.frame.origin.x - CGRectGetWidth(currentTimeLabel.frame) , CGRectGetHeight(downView.frame))];
}



// 后台
- (void)resignActiveNotification{

    isIntoBackground = YES;
    [self pause];
}

// 前台
- (void)enterForegroundNotification
{
//    DMLog(@"回到前台");
    isIntoBackground = NO;
    [self play];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _playerLayer.frame = self.bounds;
}

- (void)updatePlayerWith:(NSURL *)url{
    [self removeObserverAndNotification];
    _playerItem = [AVPlayerItem playerItemWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
    [self addObserverAndNotification];
}

- (void)addObserverAndNotification{
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听缓冲进度
    [self monitoringPlayback:_playerItem];// 监听播放状态
    [self addNotification];
}

-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 后台&前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActiveNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//这里播放完成后进行循环播放操作
-(void)playbackFinished:(NSNotification *)notification{
//    DMLog(@"视频播放完成.");
    _playerItem = [notification object];
    [_playerItem seekToTime:kCMTimeZero];
    [_player play];
}

#pragma mark - KVO - status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if (isIntoBackground) {
            return;
        }else{
            if ([item status] == AVPlayerStatusReadyToPlay) {
//                DMLog(@"AVPlayerStatusReadyToPlay");
                CMTime duration = item.duration;// 获取视频总长度
//                DMLog(@"%f", CMTimeGetSeconds(duration));
                [self setMaxDuratuin:CMTimeGetSeconds(duration)];
                [self play];
            }else if([item status] == AVPlayerStatusFailed) {
//                DMLog(@"AVPlayerStatusFailed");
            }else{
//                DMLog(@"AVPlayerStatusUnknown");
            }
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        NSTimeInterval timeInterval = [self availableDurationRanges];//缓冲进度
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.bufferProgress setProgress: timeInterval / totalDuration animated:YES];
    }
}

- (NSTimeInterval)availableDurationRanges {
    NSArray *loadedTimeRanges = [_playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)setMaxDuratuin:(float)total{
    self.playProgress.maximumValue = total;
    self.totalTimeLabel.text = [NSString convertTime:self.playProgress.maximumValue];
}

#pragma mark - _playTimeObserver
- (void)monitoringPlayback:(AVPlayerItem *)item {
    WS(ws);
    //这里设置每秒执行30次
    _playTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if (_touchMode != TouchPlayerViewModeHorizontal) {
            // 计算当前在第几秒
            float currentPlayTime = (double)item.currentTime.value/item.currentTime.timescale;
            [ws updateVideoSlider:currentPlayTime];
        }else{
            return;
        }
    }];
}

- (void)updateVideoSlider:(float)currentTime{
    if ([delegate respondsToSelector:@selector(playProgressInfo:)]) {
        [delegate playProgressInfo:currentTime];
    }
    
    self.playProgress.value = currentTime;
    self.currentTimeLabel.text = [NSString convertTime:currentTime];
    self.speedLabel.text = [NSString stringWithFormat:@"%@/%@", [NSString convertTime:currentTime], [NSString convertTime:self.playProgress.maximumValue]];
}

- (void)setlandscapeLayout{
    self.isLandscape = YES;
    [self.rotateBtn setImage:[UIImage imageNamed:@"MoviePlayer_smallScreen"] forState:UIControlStateNormal];
    

    [self setTheFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self landscapeHide];
}

- (void)setPortraitLayout{
    self.isLandscape = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    //开始播放时不隐藏状态栏
   
    [self.rotateBtn setImage:[UIImage imageNamed:@"MoviePlayer_Full"] forState:UIControlStateNormal];
    
    [self setTheFrame:frameOfPortrait];
    [self portraitShow];
}
- (void)playOrStopAction:(id)sender {
    if (_isPlaying) {
        [self pause];
    }else{
        [self play];
    }
    [self chickToolBar];
}
- (void)playerSliderDown:(id)sender {
//    DMLog(@"按动暂停");
    [self pause];
}
- (void)playerSliderInside:(id)sender {
//     DMLog(@"释放播放");
    [self play];
}
- (void)playerSliderChange:(id)sender {
    [self pause];
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(self.playProgress.value, 1);
    [_playerItem seekToTime:dragedCMTime];
    [self chickToolBar];
}

- (void)play{
    _isPlaying = YES;
    [_player play];
    [self.playBtn  setImage:[UIImage imageNamed:@"MoviePlayer_Play_Big"] forState:UIControlStateNormal];
    
    if (_isLandscape) {
        [self landscapeShow];
    }
    else {
        [self portraitShow];
    }
}

- (void)pause{
    _isPlaying = NO;
    [_player pause];
    [self.playBtn  setImage:[UIImage imageNamed:@"MoviePlayer_Stop_Big"] forState:UIControlStateNormal];
}

- (void)rotatingAction:(id)sender {
    [self chickToolBar];
    if (self.isLockScreen) {
//        DMLog(@"已锁定屏幕,请点击右上角解锁");
    }else{
        if([CLRotatingScreen isOrientationLandscape]) {
            [CLRotatingScreen forceOrientation: UIInterfaceOrientationPortrait];
            [self setPortraitLayout];
        }else{
            [CLRotatingScreen forceOrientation: UIInterfaceOrientationLandscapeRight];
            [self setlandscapeLayout];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    DMLog(@"touchBegan");
    _touchMode = TouchPlayerViewModeNone;
    UITouch *touch = [touches anyObject];
    //取得当前位置
    CGPoint currentLocation = [touch locationInView:self];
    if (currentLocation.x >[UIScreen mainScreen].bounds.size.width/2) {
        isVolumeModel = YES;
    }
    else {
        isVolumeModel = NO;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    DMLog(@"touchEnd");
    if (_touchMode == TouchPlayerViewModeNone) {
        if (self.isLandscape) {
            if (isShowToolbar) {
                [self landscapeHide];
            }else{
                [self landscapeShow];
            }
        }else{
            if (isShowToolbar) {
                [self portraitHide];
            }else{
                [self portraitShow];
            }
        }
    }else if (_touchMode == TouchPlayerViewModeHorizontal){
        CMTime offsetTime = CMTimeMake(self.playProgress.value, 1);
        [_playerItem seekToTime:offsetTime];
        self.speedView.hidden = YES;
    }
    else if (_touchMode == TouchPlayerViewModeVerticalVolume){
        
    }
    else if (_touchMode == TouchPlayerViewModeVerticalBrightness){
        
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    //取得当前位置
    CGPoint currentLocation = [touch locationInView:self];
    //取得前一个位置
    CGPoint previous = [touch previousLocationInView:self];
    CGFloat offset_x = currentLocation.x - previous.x;
    CGFloat offset_y = currentLocation.y - previous.y;
    if (offset_x < 5 && offset_x > -5&& offset_y<1&&offset_y>-1) {
//        DMLog(@"return");
        return;
    }
    else if((offset_x > 5 || offset_x < -5)&&(_touchMode == TouchPlayerViewModeHorizontal|| _touchMode == TouchPlayerViewModeNone)) {
        self.speedView.hidden = NO;
        if (offset_x > 0) {
//            DMLog(@"横向向右");
            self.speedImage.image = [UIImage imageNamed:@"MoviePlayer_stepIn"];
            [self updateVideoSlider:self.playProgress.value+1];
        }else if(offset_x < 0){
//            DMLog(@"横向向左");
            self.speedImage.image = [UIImage imageNamed:@"MoviePlayer_stepBack"];
            [self updateVideoSlider:self.playProgress.value-1];
        }
        _touchMode = TouchPlayerViewModeHorizontal;
    }
    else if((offset_y > 1 || offset_y < -1)&&isVolumeModel&&(_touchMode == TouchPlayerViewModeVerticalVolume|| _touchMode == TouchPlayerViewModeNone)){
        
        if (offset_y > 0) {
            [volumeViewSlider setValue:volumeViewSlider.value -0.02  animated:YES];
        }else if(offset_y < 0){
            [volumeViewSlider setValue:volumeViewSlider.value +0.02 animated:YES];
        }
         [volumeViewSlider sendActionsForControlEvents:UIControlEventValueChanged];
        _touchMode = TouchPlayerViewModeVerticalVolume;

    }
    else if((offset_y > 1 || offset_y < -1)&&!isVolumeModel&&(_touchMode == TouchPlayerViewModeVerticalBrightness|| _touchMode == TouchPlayerViewModeNone)) {
        if (offset_y > 0) {
           currentScreenLight = currentScreenLight -0.02;
        }else if(offset_y < 0){
           currentScreenLight = currentScreenLight +0.02;
        }
         [[UIScreen mainScreen] setBrightness:currentScreenLight];
        _touchMode = TouchPlayerViewModeVerticalBrightness;
    }
//     DMLog(@"%f",previous.x);
}

- (void)portraitShow{
    isShowToolbar = YES;
    self.topView.hidden = NO;
    self.downView.hidden = NO;
    self.playBtn.hidden = NO;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:5]; //fireDate
    [_timer invalidate];
    _timer = nil;
    _timer = [[NSTimer alloc] initWithFireDate:date interval:1 target:self selector:@selector(portraitHide) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    if (self.videoInfoL.text.length >0) {
        [self.videoInfoL setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-15 - CGRectGetHeight(self.downView.frame), CGRectGetWidth(self.view.frame), 16)];
        [self.videoInfoL setBackgroundColor:[UIColor grayColor]];
    }
}

- (void)chickToolBar{
    if (self.isLandscape) {
        [self landscapeShow];
    }else{
        [self portraitShow];
    }
}

- (void)portraitHide{
    isShowToolbar = NO;
   self.downView.hidden = self.topView.hidden = self.playBtn.hidden = YES;
    
    if (self.videoInfoL.text.length >0) {
        [self.videoInfoL setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-15, CGRectGetWidth(self.view.frame), 16)];
        [self.videoInfoL setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (void)landscapeShow{
    isShowToolbar = YES;
    self.topView.hidden = NO;
    self.downView.hidden = NO;
    self.playBtn.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:5]; //fireDate
    [_timer invalidate];
    _timer = nil;
    _timer = [[NSTimer alloc] initWithFireDate:date interval: 1 target:self selector:@selector(landscapeHide) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    if (self.videoInfoL.text.length >0) {
        [self.videoInfoL setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-15 - CGRectGetHeight(self.downView.frame), CGRectGetWidth(self.view.frame), 15)];
        [self.videoInfoL setBackgroundColor:[UIColor grayColor]];
    }
}

- (void)landscapeHide{
    isShowToolbar = NO;
    self.downView.hidden = self.topView.hidden = self.playBtn.hidden = YES;
    if (self.isLandscape) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
    
    if (self.videoInfoL.text.length >0) {
        [self.videoInfoL setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-15, CGRectGetWidth(self.view.frame), 15)];
        [self.videoInfoL setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (IBAction)lockBtnAction:(id)sender {
    if (self.isLockScreen) {
        [self unlock];
    }else{
        [self lock];
    }
    [self chickToolBar];
}

- (void)lock{
    self.isLockScreen = YES;
//    ASAppDelegate.allowRotation = NO;
    [self.lockBtn setImage:[UIImage imageNamed:@"MoviePlayer_locked"] forState:UIControlStateNormal];
}

- (void)unlock{
    self.isLockScreen = NO;
//    ASAppDelegate.allowRotation = YES;
    [self.lockBtn setImage:[UIImage imageNamed:@"MoviePlayer_lock"] forState:UIControlStateNormal];
}

- (void)dealloc{
    [self removeObserverAndNotification];
}

#pragma mark - 移除通知&KVO
- (void)removeObserverAndNotification{
    //退出播放的时候把屏幕设置回原来的亮度，并移除亮度指示图层
    [[JRSoundView sharedSoundView] removeFromSuperview];
    [[UIScreen mainScreen] setBrightness:screenLight];
    
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
