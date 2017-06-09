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
    // 导航栏和状态栏现在可以一起设置
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置下一页面的返回键
        UIButton *but = [[UIButton alloc] init];
        but.frame = CGRectMake(0, 0, 30, 20);
        [but setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateSelected];
        [but setImage:[UIImage imageNamed:@"backItem.png"] forState:UIControlStateHighlighted];
        
        but.userInteractionEnabled = YES;
        [but setTitleColor:[UIColor colorWithHexString:@"#DD1D3C"] forState:UIControlStateNormal];
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
