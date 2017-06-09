//
//  HTSegmentView.h
//  hxszy
//
//  Created by hardy on 16/6/24.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTSegmentView;

@protocol HTSegmentViewDelegate <NSObject>

@optional
-(void)segmentView:(HTSegmentView*)segmentView SelectedIndex:(NSInteger*)index NS_DEPRECATED_IOS(2_0, 8_0,"Use clickButtonIndex:(void (^)(NSInteger index))click");

@end

@interface HTSegmentView : UIView


@property(nonatomic,assign)id<HTSegmentViewDelegate> delegate NS_DEPRECATED_IOS(2_0, 8_0,"Use clickButtonIndex:(void (^)(NSInteger index))click");
/**
 显示的文字数组
 */
@property(nonatomic,strong)NSArray<NSString *>  *items;

- (void)clickButtonIndex:(void (^)(NSInteger index))click;



@end
