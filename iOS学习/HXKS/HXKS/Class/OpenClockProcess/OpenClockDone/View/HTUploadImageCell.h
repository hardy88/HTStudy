//
//  HTUploadImageCell.h
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

/*
 * 上传照片Cell
 */


#import <UIKit/UIKit.h>
@class HTUploadImageCell;

@protocol HTUploadImageCellDelegate <NSObject>

- (void)htUploadImageCellloadMoreImage;

@end

@interface HTUploadImageCell : UITableViewCell

@property(nonatomic,assign)id<HTUploadImageCellDelegate> delegate;


@property(nonatomic,strong)NSMutableArray *imgArr;

+ (CGFloat)returnCellHeight;

+ (NSString*)returnCellID;





@end
