//
//  HTClockOpenFailCell.h
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTClockOpenFailCell;

@protocol HTClockOpenFailCellDelegate <NSObject>

- (void)htClockOpenFailCell:(HTClockOpenFailCell*)cell editText:(NSString *)text;

@end



@interface HTClockOpenFailCell : UITableViewCell


@property(nonatomic,assign)id<HTClockOpenFailCellDelegate> delegate;


+ (CGFloat)returnCellHeight;

+ (NSString*)returnCellID;

@end
