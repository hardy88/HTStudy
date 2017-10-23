
#import "HTPlayer.h"
#import "UIColor+HTHexColor.h"
#import "HTPlayerFile.h"


#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)



NSString *const kHTPlayerStateChangedNotification    = @"HTPlayerStateChangedNotification";
NSString *const kHTPlayerProgressChangedNotification = @"HTPlayerProgressChangedNotification";
NSString *const kHTPlayerLoadProgressChangedNotification = @"HTPlayerLoadProgressChangedNotification";


@interface HTPlayer ()

@property (nonatomic        ) HTPlayerState  state;
@property (nonatomic        ) CGFloat        loadedProgress;//缓冲进度
@property (nonatomic        ) CGFloat        duration;//视频总时间
@property (nonatomic        ) CGFloat        current;//当前播放时间

@property (nonatomic, strong) AVPlayer       *player;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic, strong) AVPlayerLayer  *currentPlayerLayer;
@property (nonatomic, strong) NSObject       *playbackTimeObserver;
@property (nonatomic        ) BOOL           isPauseByUser; //是否被用户暂停

@property (nonatomic, weak)   UIView         *showView;


/*  控制Bar界面  */
@property (nonatomic, strong) UIView         *controllBar;
@property (nonatomic, strong) UILabel        *currentTimeLabel;
@property (nonatomic, strong) UILabel        *totolTimeLabel;
@property (nonatomic, strong) UIProgressView *videoProgressView;  //缓冲进度条
@property (nonatomic, strong) UISlider       *playSlider;  //滑竿
@property (nonatomic, strong) UIButton       *stopButton;//播放暂停按钮
@property (nonatomic, strong) UIButton       *screenBUtton;//全屏按钮


@property (nonatomic, assign) BOOL           isFullScreen;


@end

@implementation HTPlayer

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id _sInstance;
    dispatch_once(&onceToken, ^{
        _sInstance = [[self alloc] init];
    });
    
    return _sInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _isPauseByUser = YES;
        _loadedProgress = 0;
        _duration = 0;
        _current  = 0;
        _state = HTPlayerStateStopped;
        _stopWhenAppDidEnterBackground = YES;
    }
    return self;
}
- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView
{
    [self.player pause];
    [self releasePlayer];
    self.isPauseByUser = NO;
    self.loadedProgress = 0;
    self.duration = 0;
    self.current  = 0;
    self.showView  = showView;

    [self playMovie:url];
    // 观察播放器播放状态
    [self addKVO];
    // 添加通知，观察app是否进入后台
    [self addApplicationNotify];
    // 设置播放器播放状态
    if ([url.scheme isEqualToString:@"file"]) // 本地视频
    {
        [self localMoviePlayState];
    }
    else // 在线视频
    {
        [self networkMoviePlayState];
    }
    // 添加视频控制条
    [self addControllTool];
    // 添加网络变化提示
    [self netWorkMonitror];
    // 全屏->竖屏
    [self addTapGestureClickOnView];
}

- (void)localMoviePlayState
{
    // 如果已经在TBPlayerStatePlaying，则直接发通知，否则设置状态
    //
    if (self.state == HTPlayerStatePlaying)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerStateChangedNotification object:nil];
    }
    else
    {
        self.state = HTPlayerStatePlaying;
    }
}

- (void)networkMoviePlayState
{
    // 如果已经在TBPlayerStateBuffering，则直接发通知，否则设置状态
    if (self.state == HTPlayerStateBuffering)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerStateChangedNotification object:nil];
    }
    else
    {
        self.state = HTPlayerStateBuffering;
    }
}

- (void)netWorkMonitror
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerProgressChangedNotification object:nil];
}

- (void)playMovie:(NSURL *)pathUrl
{
    AVAsset *videoAsset  = [AVURLAsset URLAssetWithURL:pathUrl options:nil];
    self.currentPlayerItem  = [AVPlayerItem playerItemWithAsset:videoAsset];
    if (!self.player)
    {
        self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
    }
    else
    {
        [self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
    }
    self.currentPlayerLayer       = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.currentPlayerLayer.frame = CGRectMake(0, 0, _showView.bounds.size.width, _showView.bounds.size.height);
    [_showView.layer addSublayer:self.currentPlayerLayer];
}

- (void)addTapGestureClickOnView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(halfScreen)];
    [self.showView addGestureRecognizer:tap];
}
- (void)addKVO
{
    [self.currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.currentPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self.currentPlayerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [self.currentPlayerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)addApplicationNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.currentPlayerItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemPlaybackStalled:) name:AVPlayerItemPlaybackStalledNotification object:self.currentPlayerItem];
}

- (void)fullScreen
{
    _isFullScreen = YES;
    self.controllBar.hidden = YES;
    self.currentPlayerLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
    self.currentPlayerLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

- (void)halfScreen
{
    if (_isFullScreen)
    {
        _isFullScreen = NO;
        self.controllBar.hidden = NO;
        self.currentPlayerLayer.transform = CATransform3DIdentity;
        self.currentPlayerLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
}

- (CGFloat)progress
{
    if (self.duration > 0)
    {
        return self.current / self.duration;
    }
    return 0;
}


#pragma mark - app 进入前后台情况

- (void)appDidEnterBackground
{
    if (self.stopWhenAppDidEnterBackground)
    {
        [self pause];
        self.state = HTPlayerStatePause;
        self.isPauseByUser = NO;
    }
}
- (void)appDidEnterPlayGround
{
    if (!self.isPauseByUser)
    {
        [self resume];
        self.state = HTPlayerStatePlaying;
    }
}

- (void)playerItemDidPlayToEnd:(NSNotification *)notification
{
    [self stop];
}

//在监听播放器状态中处理比较准确
- (void)playerItemPlaybackStalled:(NSNotification *)notification
{
    // 这里网络不好的时候，就会进入，不做处理，会在playbackBufferEmpty里面缓存之后重新播放
    NSLog(@"buffing-----buffing");
}

#pragma mark -- KVO  监听播放器状态 , 这样回调的值才比较准确
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"])
    {
        if ([playerItem status] == AVPlayerStatusReadyToPlay)
        {
            [self updateMovieTotalTime:playerItem];  // 跟新视频的总时间
            
        }
        else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown)
        {
            [self stop];
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        //监听播放器的下载进度
        [self calculateDownloadProgress:playerItem];
        
    }
    else if ([keyPath isEqualToString:@"playbackBufferEmpty"])
    {
        if (playerItem.isPlaybackBufferEmpty)
        {
            self.state = HTPlayerStateBuffering;
            [self bufferingSomeSecond];
        }
    }
}

- (void)updateMovieTotalTime:(AVPlayerItem *)playerItem
{
    self.duration = playerItem.duration.value / playerItem.duration.timescale; //视频总时间
    [self.player play];
    [self updateTotolTime:self.duration];
    [self setPlaySliderValue:self.duration];
    
    __weak __typeof(self)weakSelf = self;
    
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        CGFloat current = playerItem.currentTime.value/playerItem.currentTime.timescale;
        [strongSelf updateCurrentTime:current];
        [strongSelf updateVideoSlider:current];
        if (strongSelf.isPauseByUser == NO)
        {
            strongSelf.state = HTPlayerStatePlaying;
        }
        
        // 不相等的时候才更新，并发通知，否则seek时会继续跳动
        if (strongSelf.current != current)
        {
            strongSelf.current = current;
            if (strongSelf.current > strongSelf.duration)
            {
                strongSelf.duration = strongSelf.current;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerProgressChangedNotification object:nil];
        }
        
    }];

}

- (void)calculateDownloadProgress:(AVPlayerItem *)playerItem
{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
    CMTime duration = playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    self.loadedProgress = timeInterval / totalDuration;
    [self.videoProgressView setProgress:timeInterval / totalDuration animated:YES];
}
- (void)bufferingSomeSecond
{
    // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    static BOOL isBuffering = NO;
    if (isBuffering)
    {
        return;
    }
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self.player pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 如果此时用户已经暂停了，则不再需要开启播放了
        if (self.isPauseByUser) {
            isBuffering = NO;
            return;
        }
        
        [self.player play];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.currentPlayerItem.isPlaybackLikelyToKeepUp)
        {
            [self bufferingSomeSecond];
        }
    });
}

- (void)setLoadedProgress:(CGFloat)loadedProgress
{
    if (_loadedProgress == loadedProgress) {
        return;
    }
    
    _loadedProgress = loadedProgress;
    [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerLoadProgressChangedNotification object:nil];
}

- (void)setState:(HTPlayerState)state
{
    if (state != HTPlayerStateBuffering)
    {    }

    if (_state == state)
    {
        return;
    }
    
    _state = state;
    [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerStateChangedNotification object:nil];
    
}

#pragma mark - UI界面
- (void)addControllTool
{
    [self.showView addSubview:self.controllBar];
    [self.controllBar addSubview:self.stopButton];
    [self.controllBar addSubview:self.screenBUtton];
    [self.controllBar addSubview:self.currentTimeLabel];
    [self.controllBar addSubview:self.totolTimeLabel];
    [self.controllBar addSubview:self.videoProgressView];
    [self.controllBar addSubview:self.playSlider];
}


//手指结束拖动，播放器从当前点开始播放，开启滑竿的时间走动
- (void)playSliderChangeEnd:(UISlider *)slider
{
    [self seekToTime:slider.value];
    [self updateCurrentTime:slider.value];
    [_stopButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
    [_stopButton setImage:[UIImage imageNamed:@"player_pause_hl"] forState:UIControlStateHighlighted];
}

//手指正在拖动，播放器继续播放，但是停止滑竿的时间走动
- (void)playSliderChange:(UISlider *)slider
{
    [self updateCurrentTime:slider.value];
}

#pragma mark - 控件拖动
- (void)setPlaySliderValue:(CGFloat)time
{
    _playSlider.minimumValue = 0.0;
    _playSlider.maximumValue = (NSInteger)time;
}
- (void)updateCurrentTime:(CGFloat)time
{
    // ceil 返回给定大于time的最小整数，求整数
    long videocurrent = ceil(time);
    
    NSString *str = nil;
    if (videocurrent < 3600)
    {
        str =  [NSString stringWithFormat:@"%02li:%02li",lround(floor(videocurrent/60.f)),lround(floor(videocurrent/1.f))%60];
    } else {
        str =  [NSString stringWithFormat:@"%02li:%02li:%02li",lround(floor(videocurrent/3600.f)),lround(floor(videocurrent%3600)/60.f),lround(floor(videocurrent/1.f))%60];
    }
    
    _currentTimeLabel.text = str;
}

- (void)updateTotolTime:(CGFloat)time
{
    long videoLenth = ceil(time);
    NSString *strtotol = nil;
    if (videoLenth < 3600) {
        strtotol =  [NSString stringWithFormat:@"%02li:%02li",lround(floor(videoLenth/60.f)),lround(floor(videoLenth/1.f))%60];
    } else {
        strtotol =  [NSString stringWithFormat:@"%02li:%02li:%02li",lround(floor(videoLenth/3600.f)),lround(floor(videoLenth%3600)/60.f),lround(floor(videoLenth/1.f))%60];
    }
    
    _totolTimeLabel.text = strtotol;
}


- (void)updateVideoSlider:(CGFloat)currentSecond
{
    [self.playSlider setValue:currentSecond animated:YES];
}


#pragma mark -- Player Method
- (void)resumeOrPause
{
    if (!self.currentPlayerItem)  return;
    if (self.state == HTPlayerStatePlaying)
    {
        [_stopButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
        [_stopButton setImage:[UIImage imageNamed:@"player_play_hl"] forState:UIControlStateHighlighted];
        [self.player pause];
        self.state = HTPlayerStatePause;
    }
    else if (self.state == HTPlayerStatePause)
    {
        [_stopButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        [_stopButton setImage:[UIImage imageNamed:@"player_pause_hl"] forState:UIControlStateHighlighted];
        [self.player play];
        self.state = HTPlayerStatePlaying;
    }
    self.isPauseByUser = YES;
}

- (void)resume
{
    if (!self.currentPlayerItem) return;
    
    [_stopButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
    [_stopButton setImage:[UIImage imageNamed:@"player_pause_hl"] forState:UIControlStateHighlighted];
    self.isPauseByUser = NO;
    [self.player play];
}

- (void)pause
{
    if (!self.currentPlayerItem) return;
    
    [_stopButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    [_stopButton setImage:[UIImage imageNamed:@"player_play_hl"] forState:UIControlStateHighlighted];
    self.isPauseByUser = YES;
    self.state = HTPlayerStatePause;
    [self.player pause];
}

- (void)stop
{
    self.isPauseByUser = YES;
    self.loadedProgress = 0;
    self.duration = 0;
    self.current  = 0;
    self.state = HTPlayerStateStopped;
    [self.player pause];
    [self releasePlayer];
    [[NSNotificationCenter defaultCenter] postNotificationName:kHTPlayerProgressChangedNotification object:nil];
}
- (void)seekToTime:(CGFloat)seconds
{
    if (self.state == HTPlayerStateStopped)  return;
    
    seconds = MAX(0, seconds);
    seconds = MIN(seconds, self.duration);
    
    [self.player pause];
    [self.player seekToTime:CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        self.isPauseByUser = NO;
        [self.player play];
        if (!self.currentPlayerItem.isPlaybackLikelyToKeepUp)
        {
            self.state = HTPlayerStateBuffering;
        }
        
    }];
}

#pragma mark -- seter && getter

- (AVPlayer *)player
{
    
    return _player;
}

- (UIView *)controllBar
{
    if (!_controllBar)
    {
        _controllBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.showView.bounds.size.height - 44, self.showView.bounds.size.width, 44)];
        _controllBar.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.5];
        [self.showView addSubview:_controllBar];
    }
    return _controllBar;
}

- (UIButton *)stopButton
{
    //暂停按钮
    if (!_stopButton)
    {
        _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopButton.frame = CGRectMake(0, 0, 44, 44);
        [_stopButton addTarget:self action:@selector(resumeOrPause) forControlEvents:UIControlEventTouchUpInside];
        [_stopButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        [_stopButton setImage:[UIImage imageNamed:@"player_pause_hl"] forState:UIControlStateHighlighted];
    }
    return _stopButton;
}

- (UIButton *)screenBUtton
{
    //全屏按钮
    if (!_screenBUtton)
    {
        _screenBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
        _screenBUtton.frame = CGRectMake(self.showView.bounds.size.width - 40, 0, 44, 44);
        [_screenBUtton addTarget:self action:@selector(fullScreen) forControlEvents:UIControlEventTouchUpInside];
        [_screenBUtton setImage:[UIImage imageNamed:@"player_quanping"] forState:UIControlStateNormal];
        [_screenBUtton setImage:[UIImage imageNamed:@"player_quanping"] forState:UIControlStateHighlighted];
    }
    return _screenBUtton;
}
- (UILabel *)currentTimeLabel
{
    //当前时间
    if (!_currentTimeLabel)
    {
        _currentTimeLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 0, 52, 44)];
        _currentTimeLabel.textColor = [UIColor colorWithHex:0xffffff alpha:1.0];
        _currentTimeLabel.font = [UIFont systemFontOfSize:10.0];
        _currentTimeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _currentTimeLabel;
}
- (UILabel *)totolTimeLabel
{
    //总时间
    if (!_totolTimeLabel)
    {
        _totolTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.showView.bounds.size.width-52-15, 0, 52, 44)];
        _totolTimeLabel.textColor = [UIColor colorWithHex:0xffffff alpha:1.0];
        _totolTimeLabel.font = [UIFont systemFontOfSize:10.0];
        _totolTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _totolTimeLabel;
}
- (UIProgressView *)videoProgressView
{
    if (!_videoProgressView)
    {
        _videoProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(62+30, 21, self.showView.bounds.size.width-124-44, 20)];
        _videoProgressView.progressTintColor = [UIColor colorWithHex:0xffffff alpha:1.0];  //填充部分颜色
        _videoProgressView.trackTintColor = [UIColor colorWithHex:0xffffff alpha:0.18];   // 未填充部分颜色
        _videoProgressView.layer.cornerRadius = 1.5;
        _videoProgressView.layer.masksToBounds = YES;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.5);
        _videoProgressView.transform = transform;
    }
    return _videoProgressView;
}
- (UISlider *)playSlider
{
    if (!_playSlider)
    {
        
        _playSlider = [[UISlider alloc] initWithFrame: CGRectMake(62+30, 0, self.showView.bounds.size.width-124-44, 44)];
        [_playSlider setThumbImage:[UIImage imageNamed:@"icon_progress"] forState:UIControlStateNormal];
        _playSlider.minimumTrackTintColor = [UIColor clearColor];
        _playSlider.maximumTrackTintColor = [UIColor clearColor];
        [_playSlider addTarget:self action:@selector(playSliderChange:) forControlEvents:UIControlEventValueChanged]; //拖动滑竿更新时间
        [_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpInside];  //松手,滑块拖动停止
        [_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpOutside];
        [_playSlider addTarget:self action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchCancel];
    }
    return _playSlider;
}
#pragma mark -- To Dealloc Property
- (void)dealloc
{
    [self releasePlayer];
}
- (void)releasePlayer
{
    if (!self.currentPlayerItem) return;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.player removeTimeObserver:self.playbackTimeObserver];
    self.playbackTimeObserver = nil;
    self.currentPlayerItem = nil;
}
@end
