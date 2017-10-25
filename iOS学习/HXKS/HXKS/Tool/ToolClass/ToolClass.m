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

+ (BOOL)containsChinese:(NSString *)str
{
    for (int i = 0; i < str.length; i++)
    {
        unichar ch = [str characterAtIndex:i];
        if ((int)(ch)>127)
        {
            return YES;
        }
        else if((ch >64)&&(ch <91)){
            NSLog(@"字符串中含有大写英文字母");
            return NO;
        }else if((ch >96)&&( ch<123)){
            NSLog(@"字符串中含有小写英文字母");
            return NO;
        }else if((ch>47)&&(ch<58)){
            NSLog(@"字符串中含有数字");
            return NO;
        }else{
            NSLog(@"字符串中含有非法字符");
            return NO;
        }
    }
    return NO;
}
+ (void)openSystemSetting
{
    NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:settingUrl])
    {
        [[UIApplication sharedApplication] openURL:settingUrl];
    }
}
@end
