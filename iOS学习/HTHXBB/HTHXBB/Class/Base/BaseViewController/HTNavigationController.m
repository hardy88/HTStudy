//
//  HTNavigationController.m
//  HTHXBB
//
//  Created by hardy on 17/1/22.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTNavigationController.h"

@interface HTNavigationController ()

@end

@implementation HTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)initialize
{
    //设置导航栏背景颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor lightGrayColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置下一页面的返回键
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, 0, 50, 20);
        [but setImage:[UIImage imageNamed:@"nav_back_black.png"] forState:UIControlStateNormal];
        [but setTitle:@"<返回" forState:UIControlStateNormal];
        but.userInteractionEnabled = YES;
        [but addTarget:self action:@selector(toBack) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:but];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)toBack
{
    [self popViewControllerAnimated:YES];
}

- (void)toNext:(UIViewController*)vc
{
    [self pushViewController:vc animated:YES];
}


@end
