//
//  HTTime.h
//  
//
//  Created by hardy on 16/5/16.
//  Copyright © 2016年 Hardy Hu. All rights reserved.

/*!
 *  处理时间
 */


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTDateType) {
    HTDate_Type_One, // YYYY-MM-dd
    HTDate_Type_Two, //
    HTDate_Type_Three, //
};

@interface HTTime : NSObject

/*!
 *  获取当前时间
 *
 *  @return (NSString*) 当前时间
 */
+(NSString*)currentDateStr;
/*!
 *  获取当前时间
 *
 *  @return (NSDate*) 当前时间
 */
+(NSDate*)currentDate;


@end
