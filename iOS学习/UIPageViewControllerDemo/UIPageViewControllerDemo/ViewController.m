//
//  ViewController.m
//  UIPageViewControllerDemo
//
//  Created by hardy on 2017/9/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<UIPageViewControllerDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *options1 = @{UIPageViewControllerOptionInterPageSpacingKey : @(0)};
    
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options1];
    pageController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    pageController.dataSource = self;

    
    FirstViewController *vc1 = [[FirstViewController alloc] init];
    vc1.pageIndex = 0;
    NSArray *vcsArr = @[vc1];
    
    [pageController setViewControllers:vcsArr direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
    
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController;
{
   
    NSUInteger index = ((HTBaseViewController *) viewController).pageIndex;
    if (index == 0 || index == NSNotFound)
    {
        return nil;
    }
    index -= 1;
    return [self viewControllerAtIndex:index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{

     NSUInteger index = ((HTBaseViewController *) viewController).pageIndex;
    if (index == NSNotFound)
    {
        return nil;
    }
    index += 1;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    switch (index)
    {
        case 0:
        {
            FirstViewController *vc1 = [[FirstViewController alloc] init];
            vc1.pageIndex = index;
            return vc1;
        }
            break;
        case 1:
        {
            SecondViewController *vc2 = [[SecondViewController alloc] init];
            vc2.pageIndex = index;
            return vc2;
        }
            break;
        default:
            return nil;
            break;
    }
}



@end
