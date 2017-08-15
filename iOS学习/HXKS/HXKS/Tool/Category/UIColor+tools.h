//
//  UIColor+tools.h
//  TSPizza
//
//  Created by taiyh on 14/10/21.
//  Copyright (c) 2014年 ETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (tools)

/*!
 *  改写UIColor的方法，不需要自己除以255.0f;
 *
 *  @param red   红色值
 *  @param green 绿色值
 *  @param blue  蓝色值
 *  @param alpha 透明度
 *
 *  @return
 */
+(UIColor *)customColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
/*!
 *  改写UIColor的方法，不需要自己除以255.0f;
 *
 *  @param red   红色值
 *  @param green 绿色值
 *  @param blue  蓝色值
 *
 *  @return
 */
+(UIColor *)customColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
/*!
 *  16进制转换为颜色
 *
 *  @param hexString 16进制
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
/*!
 *  16进制转换为颜色,并传入透明度
 *
 *  @param hexString 16进制
 *  @param alpha     透明度
 *
 *  @return 
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/*!
 *  设置背景颜色
 *
 *  @return
 */
+(UIColor *)returnMainUIColor;
/*!
 *  设置正文文字颜色
 *
 *  @return
 */
+(UIColor *)returnMainTextColor;
/*!
 *  设置附属文字颜色
 *
 */
+(UIColor *)returnDetailTextColor;
/*!
 *  设置TableView SectionHeaderView Color
 *
 *  @return
 */
+(UIColor *)returnSectionHeaderViewColor;
/*!
 *  设置边框颜色
 *
 *  @return
 */
+(UIColor *)returnBorderColor;
/*!
 *  导航栏背景色
 *
 *  @return
 */
+(UIColor *)returnNavBackGroundColor;
/*!
 *  TabBar文字颜色
 *
 *  @return
 */
+(UIColor *)returnTabBarColor;
/*!
 *  TableView BackGround Color
 *
 *  @return <#return value description#>
 */
+(UIColor *)returnTableViewBackGroundColor;


/**
 Cell背景色

 @return <#return value description#>
 */
+ (UIColor *)returnCellBackGroundColor;

@end
