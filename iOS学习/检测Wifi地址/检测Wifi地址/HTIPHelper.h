//
//  HTIPHelper.h
//  检测Wifi地址
//
//  Created by hardy on 2017/6/12.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTIPHelper : NSObject


/**
 Wifi是否开启

 @return YES-打开Wifi
         No - 关闭Wifi
 */
+ (BOOL) isWiFiOpened;


/**
 获取当前Ip地址

 @return Wifi Ip地址
 */
+ (nullable NSString*)getCurrentWifiIP;



/**
 当前WIFI名称

 @return wifi名称
 */
+ (nullable NSString *)getCurretWiFiSsid;



@end
