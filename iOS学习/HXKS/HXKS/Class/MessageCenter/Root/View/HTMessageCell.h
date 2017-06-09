//
//  HTMessageCell.h
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 消息中心
 */


#import <UIKit/UIKit.h>
#import "HTMessageSuccessModel.h"

@interface HTMessageCell : UITableViewCell


@property(nonatomic,strong)HTMessageSuccessModel *model;

+ (CGFloat)returnCellHeight;

+ (NSString*)returnCellID;

@end
