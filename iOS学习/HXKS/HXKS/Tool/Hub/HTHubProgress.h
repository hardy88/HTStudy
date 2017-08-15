//
//  HTHubProgress.h
//  HXKS
//
//  Created by hardy on 2017/7/20.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Hub
 */


@interface HTHubProgress : NSObject


// 一直加载中。。需要主动停止
+ (void)showWaitMessage:(NSString*)message onView:(UIView*)onView;

// 隐藏
+ (void)hideHub:(UIView*)onView;



// 提示语，2S后自动消失
+ (void)showHintMessage:(NSString*)message onView:(UIView*)onView;

@end
