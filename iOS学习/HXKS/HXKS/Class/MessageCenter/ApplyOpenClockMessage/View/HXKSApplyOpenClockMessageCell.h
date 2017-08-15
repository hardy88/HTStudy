//
//  HXKSApplyOpenClockMessageCell.h
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXKSApplyOpenClockMessageCellDelegate <NSObject>

// 清除
- (void)HXKSApplyOpenClockMessageCellClear:(NSInteger)index;
// 接受申请
- (void)HXKSApplyOpenClockMessageCellAcceptApply:(NSInteger)index;

@end



@interface HXKSApplyOpenClockMessageCell : UITableViewCell

@property(nonatomic,assign)id<HXKSApplyOpenClockMessageCellDelegate> delegate;

// 标记Cell
@property(nonatomic,assign)NSInteger index;

+ (CGFloat)returnCellHight;

+ (NSString *)returnCellId;

@end

