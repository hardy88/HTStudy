//
//  ToolClass.h
//  HTHXBB
//
//  Created by hardy on 2017/3/10.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ToolClass : NSObject

/**
 判断一个对象是否为手机号
 
 @param phoneStr 手机号
 @return YES-是手机号 NO-不是手机号
 */
+ (BOOL)isPhoneNum:(NSString*)phoneStr;


/**
 判断一个对象是否为空

 @param obj 任意类型的对象
 @return YES-空值 NO-非空值
 */
+ (BOOL)isEmpty:(id)obj;


/**
 获取字符串Size大小

 @param text （NSString*）文本
 @param fontSize 文字大小
 @return （CGSize）大小
 */
+ (CGSize)textCgsize:(NSString*)text FontSize:(CGFloat)fontSize;


@end
