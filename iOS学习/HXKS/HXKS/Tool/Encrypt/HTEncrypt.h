//
//  HTEncrypt.h
//  hxszy
//
//  Created by hardy on 16/6/13.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTEncrypt : NSObject
/*!
 *  md5 加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 加密后字符串
 */
+(NSString*)toMd5:(NSString*)str;
/*!
 *  将文本转换为base64格式字符串
 *
 *  @param text 要加密的字符串
 *
 *  @return base64格式字符串
 */
+(NSString*)toBase64:(NSString*)text;
/*!
 *  将base64格式字符串转换为文本
 *
 *  @param text base64格式字符串
 *
 *  @return 文本
 */
+(NSString*)base64ToText:(NSString*)text;
/*!
 *  文本数据进行DES加密(此函数不可用于过长文本)
 *
 *  @param data 需要加密的data
 *  @param key  加密key
 *
 *  @return data
 */
+(NSData*)toDES:(NSData*)data Key:(NSString*)key;
/*!
 *  文本数据进行DES解密(此函数不可用于过长文本)
 *
 *  @param data <#data description#>
 *  @param key  <#key description#>
 *
 *  @return <#return value description#>
 */
+(NSData*)desToData:(NSData*)data key:(NSString*)key;


/**
 利用系统自带的Json
 对象转Json字符串

 @param object NSDiction | NSData
 @return Json 字符串
 */
+ (NSString *)objectToJason:(id)object;


/**
 json字符穿转为NSDiction

 @param json json格式字符串
 @return (NSDiction*)对象
 */
+ (id)jsonToObject:(NSString*)json;


/**
 自定义加密方式：
 利用key对字符串先进行DES加密，再进行Base64加密

 @param text 字符串
 @param key key
 @return base64字符串
 */
+ (NSString *)toBase64:(NSString *)text withDesKey:(NSString*)key;

@end
