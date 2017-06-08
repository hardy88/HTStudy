//
//  RootVc.m
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import "RootVc.h"
#import "LeftVc.h"
#import "RightVc.h"
#import "HTNextViewController.h"


@interface RootVc ()
{
}
@end

@implementation RootVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];

}

- (void)setSideVC:(UIViewController*)side
      andContatinerVC:(UIViewController*)contatin
{
    self.leftVC = side;
    self.mainVC = contatin;
    
    [self.view addSubview:self.leftVC.view];
    
    [self addChildViewController:contatin];
    [self.view addSubview:self.mainVC.view];
}

-(void)closeSide
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainVC.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    [UIView commitAnimations];
}

- (void)openSide
{
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
    self.mainVC.view.center =  CGPointMake([UIScreen mainScreen].bounds.size.width + [UIScreen mainScreen].bounds.size.width * 1 /2 -100, [UIScreen mainScreen].bounds.size.height / 2);
    [UIView commitAnimations];
    
//    [UIView animateWithDuration:1.5 animations:^{
//       
//        self.mainVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -100, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        
//    }];
}

@end
