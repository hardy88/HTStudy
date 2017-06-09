//
//  AppDelegate.h
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "HTNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;

@property (nonatomic,strong) HTNavigationController *mainVC;


@property(nonatomic,copy)NSString *curLatitude; // 纬度
@property(nonatomic,copy)NSString *curLongtitude; // 经度

@end

