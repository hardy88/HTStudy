//
//  HTAVPlayer.m
//  TBPlayer
//
//  Created by hardy on 2017/10/20.
//  Copyright © 2017年 . All rights reserved.
//

#import "HTAVPlayer.h"
#import "HTPlayer.h"

@interface HTAVPlayer ()

@property (nonatomic,strong) HTPlayer  *player;

@end

@implementation HTAVPlayer
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.player = [HTPlayer sharedInstance];
    }
    return self;
}
- (void)setUrlPath:(NSURL *)urlPath
{
    [self.player playWithUrl:urlPath showView:self];
}
- (void)play
{
    [self.player resume];
}
- (void)stop
{
    [self.player stop];
}
- (void)pause
{
    [self.player pause];
}
@end
