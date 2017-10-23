//
//  NextViewController.m
//  HTPlayerDemo
//
//  Created by hardy on 2017/10/23.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "NextViewController.h"
#import "HTAVPlayer.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HTAVPlayer *player = [[HTAVPlayer alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    player.urlPath = [NSURL URLWithString:@"http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0"];
    [player play];
    [self.view addSubview:player];
}


@end
