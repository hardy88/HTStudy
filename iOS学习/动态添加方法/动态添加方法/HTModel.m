//
//  HTModel.m
//  动态添加方法
//
//  Created by hardy on 2017/6/29.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTModel.h"
#import <objc/message.h>

@implementation HTModel

void printObj(id self, SEL _cmd)
{
    NSLog(@" 调用了方法%@, %@",self,
          NSStringFromSelector(_cmd));
}
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(printObj))
    {
        class_addMethod(self, sel, (IMP)printObj, "V@:");
        return YES;
    }
    return  [super resolveClassMethod:sel];
}

@end
