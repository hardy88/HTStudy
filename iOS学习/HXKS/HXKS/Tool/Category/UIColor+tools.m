//
//  UIColor+tools.m
//  TSPizza
//
//  Created by taiyh on 14/10/21.
//  Copyright (c) 2014年 ETS. All rights reserved.
//

#import "UIColor+tools.h"

@implementation UIColor (tools)

/*!
 *  十六进制转换为颜色+ 不透明
 *
 *  @param hexString 十六进制
 *
 *  @return
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [self colorWithHexString:hexString alpha:1.0f];
}
/*!
 *  十六进制转换为颜色 + 透明度
 *
 *  @param hexString 十六进制
 *  @param alpha     透明度
 *
 *  @return
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if ([hexString length] <6) //长度不合法
    {
        return [UIColor blackColor];
    }
    NSString *tempString=[hexString lowercaseString];
    
    if ([tempString hasPrefix:@"0x"]) //检查开头是0x
    {
        tempString = [tempString substringFromIndex:2];
    }
    else if ([tempString hasPrefix:@"#"]) //检查开头是#
    {
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6)
    {
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:alpha];
}
+(UIColor *)customColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float) red /255.0f)
                           green:((float) green /255.0f)
                            blue:((float) blue /255.0f)
                           alpha:alpha];
}
+(UIColor *)customColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor colorWithRed:((float) red /255.0f)
                           green:((float) green /255.0f)
                            blue:((float) blue /255.0f)
                           alpha:1.0f];
}

+(UIColor *)returnMainUIColor
{
    // 青色
    return [UIColor colorWithHexString:@"#00b4e6"];
}
+(UIColor *)returnMainTextColor
{
    // 黑色
    return [UIColor colorWithHexString:@"#333333"];
}
+(UIColor *)returnDetailTextColor
{
    // 黑色
    return [UIColor colorWithHexString:@"#8c8c8c"];
}
+(UIColor *)returnSectionHeaderViewColor
{
    // 灰色
    return [UIColor colorWithHexString:@"#F6F6F6"];
}
+(UIColor *)returnBorderColor
{
    // 灰色
    return [UIColor colorWithHexString:@"#6a6a6a"];
}
+(UIColor *)returnNavBackGroundColor
{
    // 青色
    return [UIColor colorWithHexString:@"#FFFFFF"];
}
+(UIColor *)returnTabBarColor
{
     return [UIColor colorWithHexString:@"#FD7A4A"];
}
+(UIColor *)returnTableViewBackGroundColor
{
    // 灰色
    return [UIColor colorWithHexString:@"#F6F6F6"];
}

@end
