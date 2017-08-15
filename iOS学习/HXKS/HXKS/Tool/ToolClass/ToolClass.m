//
//  ToolClass.m
//  HTHXBB
//
//  Created by hardy on 2017/3/10.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass

+ (BOOL)isPhoneNum:(NSString*)phoneStr
{
    //手机号以13、15、18开头，八个\d数字字符
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneStr];
}

+ (BOOL)isEmpty:(id)obj
{
    if ([obj isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (!obj)
    {
        return YES;
    }
    else if ([obj isEqual:@""])
    {
        return YES;
    }
    return NO;
}

+ (CGSize)textCgsize:(NSString*)text FontSize:(CGFloat)fontSize
{
    if (text)
    {
        CGSize size = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
        return size;
    }
    return CGSizeZero;
}

@end
