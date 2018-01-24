//
//  HTEmojHelp.m
//  textAndImage
//
//  Created by hardy on 2018/1/23.
//  Copyright © 2018年 Hardy Hu. All rights reserved.
//

#import "HTEmojHelp.h"
#import <UIKit/UIKit.h>

@implementation HTEmojHelp

+ (NSString *)encodeEmoj:(NSString *)emojStr
{
    NSString *inputText = [emojStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return inputText;
}
/**
 解码服务器返回的含有表情的字符串，方便移动端显示
 
 @param serviceStr 服务器返回的字符串
 */
+ (NSString *)decodeEmoj:(NSString *)serviceStr
{
    return [serviceStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
