//
//  HTJsonObjectTarnslate.m
//  HXKS
//
//  Created by hardy on 2017/10/25.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTJsonObjectTarnslate.h"

@implementation HTJsonObjectTarnslate

+ (NSData *)objToJsonData:(id)obj
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
+ (NSString *)objToJsonStr:(id)obj
{
    NSData *jsonData = [self objToJsonData:obj];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (id)jsonDataToObj:(NSData *)jsonData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}
+ (id)jsonStrToObj:(NSString *)jsonStr
{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return [self jsonDataToObj:jsonData];
}
+ (NSString *)arrToString:(NSArray *)arr
{
    return [arr componentsJoinedByString:@","];
}
+ (NSArray *)stringToArray:(NSString *)str
{
    return [str componentsSeparatedByString:@","];
}
+ (NSString *)convertUnicodeToChinese:(NSString*)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
@end

