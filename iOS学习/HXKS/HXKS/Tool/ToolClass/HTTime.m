//
//  HTTime.m
//  
//
//  Created by hardy on 16/5/16.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import "HTTime.h"

@implementation HTTime

+(NSString*)currentDateStr
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currStr = [formatter stringFromDate:date];
    return currStr;
}
+(NSDate*)currentDate
{
    NSDate *date = [NSDate date];
    return date;
}

@end
