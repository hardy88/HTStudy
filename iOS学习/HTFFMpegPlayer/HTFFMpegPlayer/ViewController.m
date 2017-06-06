//
//  ViewController.m
//  HTFFMpegPlayer
//
//  Created by hardy on 2017/6/2.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"


#import "HTFFMpegPlayerView.h"


@interface ViewController ()
{
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    HTFFMpegPlayerView *playerView = [[HTFFMpegPlayerView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width -20, 200)];
    playerView.videoPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp4"];
    [playerView play];
    [self.view addSubview:playerView];
}



@end
