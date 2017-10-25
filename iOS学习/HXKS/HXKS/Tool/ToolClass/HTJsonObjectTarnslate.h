//
//  HTJsonObjectTarnslate.h
//  HXKS
//
//  Created by hardy on 2017/10/25.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface HTJsonObjectTarnslate : NSObject


/**
 字典或数组转化为Json Data

 @param obj 字典或数组
 @return Json Data
 */
+ (NSData *)objToJsonData:(id)obj;


/**
 字典或者数组转化为json字符串数据

 @param obj 字典或者数组
 @return json字符串数据
 */
+ (NSString *)objToJsonStr:(id)obj;


/**
 Json Data转化为字典或者数组

 @param jsonData Json Data
 @return 字典或者数组
 */
+ (id)jsonDataToObj:(NSData *)jsonData;


/**
 JSON串转化为字典或者数组

 @param jsonStr JSON串
 @return 字典或者数组
 */
+ (id)jsonStrToObj:(NSString *)jsonStr;


/**
 NSArray转为NSString

 @param arr NSArray
 @return NSString
 */
+ (NSString *)arrToString:(NSArray *)arr;


/**
 NSString转为NSArray

 @param str NSString
 @return NSArray
 */
+ (NSArray *)stringToArray:(NSString *)str;


/**
 unicode转换为中文

 @param unicodeStr unicode字符串
 @return 中文
 */
+ (NSString *)convertUnicodeToChinese:(NSString*)unicodeStr;
@end
