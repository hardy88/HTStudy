//
//  ToolClass.m
//  HTHXBB
//
//  Created by hardy on 2017/3/10.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass

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
