//
//  HTBaseViewController.h
//  HTHXBB
//
//  Created by hardy on 17/1/20.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTNavigationController.h"

@interface HTBaseViewController : UIViewController

/**
 导航栏
 */
@property (nonatomic, strong)HTNavigationController *curNav;

/**
 导航栏标题
 */
@property (nonatomic, copy)NSString *navTitle;

/**
  导航栏左item标题，点击后返回上一页
 */
@property (nonatomic, copy)NSString *leftNavTitle;

/**
 导航栏左item
 @param leftNavTitle 左item标题
 @param action 左item点击事件，点击事件为自定义
 */
- (void)addLeftNavText:(NSString*)leftNavTitle
             action:(SEL)action;

/**
 导航栏右item
 @param rightNavTitle 右item标题
 @param action 右item点击事件，点击事件为自定义
 */
- (void)addRightNavText:(NSString*)rightNavTitle
             action:(SEL)action;

/**
 隐藏左item
 */
- (void)hideLeftItem;

@end
