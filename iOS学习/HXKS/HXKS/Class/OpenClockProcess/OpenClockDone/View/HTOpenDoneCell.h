//
//  HTOpenDoneCell.h
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

//model
#import "HTOpenClockOrderModel.h"

@interface HTOpenDoneCell : UITableViewCell

+ (CGFloat)returnCellHeight;

+ (NSString*)returnCellID;

- (void)configCellWithModel:(HTOpenClockOrderModel*)model;


@end
