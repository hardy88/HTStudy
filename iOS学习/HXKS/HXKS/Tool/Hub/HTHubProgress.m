//
//  HTHubProgress.m
//  HXKS
//
//  Created by hardy on 2017/7/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTHubProgress.h"
#import "ProgressHUD.h"
#import "MBProgressHUD+MJ.h"

@implementation HTHubProgress


// 一直加载中。。需要主动停止
+ (void)showWaitMessage:(NSString*)message onView:(UIView*)onView
{
      [MBProgressHUD showMessage:message toView:onView];
}

// 隐藏
+ (void)hideHub:(UIView*)onView
{
    [MBProgressHUD hideHUDForView:onView];
}
+ (void)showHintMessage:(NSString*)message onView:(UIView*)onView
{
   [ProgressHUD showInfo:message onView:onView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ProgressHUD hideOnView:onView];
    });
}

@end
