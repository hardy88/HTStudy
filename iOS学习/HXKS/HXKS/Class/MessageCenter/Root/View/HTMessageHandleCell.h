//
//  HTMessageHandleCell.h
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMessageHandleModel.h"
@class HTMessageHandleCell;

@protocol HTMessageHandleCellDelegate <NSObject>

- (void)HTMessageHandleCellCheckDetailInfo;

@end




@interface HTMessageHandleCell : UITableViewCell


@property(nonatomic,assign)id<HTMessageHandleCellDelegate> delegate;

@property(nonatomic,strong)HTMessageHandleModel *model;


+ (CGFloat)returnCellHeight;

+ (NSString*)returnCellID;

@end
