//
//  HTFather+Extention.m
//  给分类添加属性
//
//  Created by hardy on 2017/6/29.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTFather+Extention.h"
#import <objc/runtime.h>

@implementation HTFather (Extention)

static char *modelNameKey = "htModelNameKey";
-(void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, modelNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    return objc_getAssociatedObject(self, modelNameKey);
}

@end
