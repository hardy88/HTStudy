//
//  HTEmojHelp.h
//  textAndImage
//
//  Created by hardy on 2018/1/23.
//  Copyright © 2018年 Hardy Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTEmojHelp : NSObject


/**
  对含有表情的字符串进行编码，方便上传给服务端

 @param emojStr 含有表情的字符串.
 */
+ (NSString *)encodeEmoj:(NSString *)emojStr;


/**
 解码服务器返回的含有表情的字符串，方便移动端显示

 @param serviceStr 服务器返回的字符串
 */
+ (NSString *)decodeEmoj:(NSString *)serviceStr;

@end
