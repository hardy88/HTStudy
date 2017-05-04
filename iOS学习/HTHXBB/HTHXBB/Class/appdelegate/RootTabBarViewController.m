//
//  RootTabBarViewController.m
//  HTHXBB
//
//  Created by hardy on 17/1/22.
//  Copyright © 2017年 hardy. All rights reserved.
//

// vc
#import "RootTabBarViewController.h"
#import "HTNavigationController.h"
#import "HTHomeViewController.h"
#import "HTServiceViewController.h"
#import "HTMessageViewController.h"
#import "HTProfileViewController.h"


@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HTHomeViewController    *homeVc = [[HTHomeViewController alloc] init];
    HTServiceViewController *serviceVc = [[HTServiceViewController alloc] init];
    HTMessageViewController *messageVc = [[HTMessageViewController alloc] init];
    HTProfileViewController *profileVc = [[HTProfileViewController alloc] init];

    [self addSubTabBarViewController:@[homeVc,serviceVc,messageVc,profileVc] title:@[@"首页",@"服务",@"信息",@"个人"]];
}

- (void) addSubTabBarViewController:(NSArray*)viewController
                              title:(NSArray*)title
{
    if (   [viewController count] > 0
        && [title count] == [viewController count])
    {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < viewController.count; i++)
        {
            HTNavigationController *nav = [[HTNavigationController alloc] initWithRootViewController:viewController[i]];
            nav.tabBarItem.title = title[i];
            [arr addObject:nav];
        }
        self.viewControllers = arr;
    }
}

@end
