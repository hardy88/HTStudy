//
//  HTHomeViewController.m
//  HTHXBB
//
//  Created by hardy on 17/1/22.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTHomeViewController.h"
#import "HTVideoViewController.h"

@interface HTHomeViewController ()

@end

@implementation HTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupBaseView
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navTitle = @"首页";
    
    
    [self createBanner];
    
    
}


- (void)createBanner
{
    UIImageView *bannerView = [[UIImageView alloc] init];
    
}

- (void)push
{
    HTVideoViewController *p = [[HTVideoViewController alloc] init];
    [self.curNav pushViewController:p animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HTVideoViewController *p = [[HTVideoViewController alloc] init];
    [self.curNav pushViewController:p animated:YES];
}

- (void)toDone
{
    NSLog(@"完成");
}

@end
