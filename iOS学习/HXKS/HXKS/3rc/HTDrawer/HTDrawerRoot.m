//
//  RootVc.m
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import "HTDrawerRoot.h"

#import "ProfileViewController.h"
#import "HTHomeViewCotroller.h"
#import "HTNavigationController.h"

@interface HTDrawerRoot ()<LeftVcDelegate>
{
    HTHomeViewCotroller *htContentVC;
}
@end

@implementation HTDrawerRoot

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)setupBaseView
{
    self.view.backgroundColor = [UIColor purpleColor];
    
    ProfileViewController *left = [[ProfileViewController alloc] init];
    left.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    left.delegate = self;
    [self addChildViewController:left];
    [self.view addSubview:left.view];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    
    

    
//    htContentVC = [[HTDrawerContent alloc] init];
//    HTNavigationController *nvc = [[HTNavigationController alloc] initWithRootViewController:htContentVC];
//    [self addChildViewController:nvc];
//    htContentVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [self.view addSubview:htContentVC.view];
}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
    // 发生请求
}

-(void)LeftVcClick
{
    
    [UIView animateWithDuration:1.5 animations:^{
        htContentVC.view.frame= CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        htContentVC.message = @"我是来自侧滑";
    }];
    
    
}

@end
