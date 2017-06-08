//
//  RootVc.h
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootVc : UIViewController

//左侧窗控制器
@property (nonatomic, strong) UIViewController *leftVC;

@property (nonatomic,strong) UIViewController *mainVC;

@property(nonatomic,strong)UINavigationController *mainNav;

//- (void)setSideVC:(UIViewController*)side
//      andContatinerVC:(UIViewController*)contatin;

- (void)openSide;

- (void)closeSide;


- (void)start;

@end
