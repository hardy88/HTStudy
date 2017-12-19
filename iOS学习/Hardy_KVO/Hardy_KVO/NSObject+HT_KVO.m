//
//  NSObject+HT_KVO.m
//  Hardy_KVO
//
//  Created by hardy on 2017/12/18.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "NSObject+HT_KVO.h"
#import <objc/message.h>

@implementation NSObject (HT_KVO)

- (void)ht_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    /*
      1. 自定义类
      2. 重写方法
      3. 修改当前对象的ISA指针，指向自定义的类
     */
    
    // 1. 动态创建一个子类
    // 拿到类名
   NSString *oldClassName = NSStringFromClass([self class]);
    //
    NSString *newClassName = [@"htKVO_" stringByAppendingString:oldClassName];
    
    const char *newName = [newClassName UTF8String];
    // 创建类
   Class kvoClass =  objc_allocateClassPair([self class], newName, 0);

    // 注册类
    objc_registerClassPair(kvoClass);
    
    //添加set方法
    // cls 添加新方法的类；  name 表示selector的方法名称；  imp 指向一个方法的实现，可以根据喜好进行命名； types 表示我们要添加方法的返回值和参数：  v 代表函数的返回值类型 void,  :@ 表示调用setName：函数的时的参数
    class_addMethod(kvoClass, @selector(setName:), (IMP)setName, "v@:@");
    
    // 修改isa指针,
    object_setClass(self, kvoClass);
    
    // 保存观察者对象
    objc_setAssociatedObject(self, @"kvo_key", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


void setName(id self, SEL _cmd, NSString *newName)
{
   
    // 保存该类的类型
    id class = [self class];
    // 修改isa指针,
    object_setClass(self, class_getSuperclass(class));
    // 调用父类的方法
    objc_msgSend(self, @selector(setName:),newName);
    // 拿到观察者
    id objc = objc_getAssociatedObject(self, @"kvo_key");
    // 通知观察者方法
    objc_msgSend(objc, @selector(observeValueForKeyPath:ofObject:change:context:),@"Name",objc,@{@"new":newName},nil);
    object_setClass(self, class);
}

@end
