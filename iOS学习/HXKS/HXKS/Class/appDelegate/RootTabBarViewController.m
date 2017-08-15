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
#import "ApplyViewController.h"

#import "ProfileViewController.h"
#import "HXKSLoginViewController.h"





@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    HomeViewController    *homeVc = [[HomeViewController alloc] init];
//    ApplyViewController *serviceVc = [[ApplyViewController alloc] init];
//    ProfileViewController *profileVc = [[ProfileViewController alloc] init];
//    HXLoginViewController *loginVc = [[HXLoginViewController alloc] init];
//
//    [self addSubTabBarViewController:@[homeVc,serviceVc,profileVc,loginVc] title:@[@"首页",@"申请",@"设置",@"登录"]];
}

- (void)addChildViewController:(UIViewController*)vc itemTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectedImage
{
    if (!vc) {
        return;
    }
    HTNavigationController *nav = [[HTNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
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
            nav.tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [arr addObject:nav];
        }
        self.viewControllers = arr;
    }
}


@end
