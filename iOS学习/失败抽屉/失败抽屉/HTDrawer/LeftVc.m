//
//  LeftVc.m
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import "LeftVc.h"
#import "AppDelegate.h"
#import "HTNextViewController.h"

@interface LeftVc ()

@end

@implementation LeftVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *clickBut = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBut.frame = CGRectMake(10, 200, 100, 30);
    [clickBut setTitle:@"关闭" forState:UIControlStateNormal];
    [clickBut setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [clickBut addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBut];
    
    
//    UIButton *nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    nextBut.frame = CGRectMake(10, 300, 100, 30);
//    [nextBut setTitle:@"下一页" forState:UIControlStateNormal];
//    [nextBut setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//    [nextBut addTarget:self action:@selector(nextBut:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nextBut];
}

- (void)clickBut:(UIButton*)but
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainVC closeSide];
}

- (void)nextBut:(UIButton*)but
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainVC closeSide];

}

@end
