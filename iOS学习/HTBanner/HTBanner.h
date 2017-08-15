//
//  HTBanner.h
//  HTBanner
//
//  Created by hardy on 2017/8/15.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface HTBanner : UIView


/**
 构造方法

 @param frame 轮播View的Frame
 @param imageArr 图片数组
 @param itemSize 要显示图片的Size
 @return return HTBanner实例
 
 说明： 默认是水平方向的滚动。
 
 */
- (instancetype)initWithFrame:(CGRect)frame
                     imageArr:(NSArray*)imageArr
                itemSizeWidth:(CGSize )itemSize;


/**
 背景色
 默认 白色
 */
@property(nonatomic,strong)UIColor *backGroundColor;

/**
 水平方向，item之间的间隙，默认为0
 */
@property(nonatomic,assign)CGFloat miniInterItemSpacing;


/**
 水平方向， Section到边框的边距（上，左，下，右），默认（0，0，0，0）
 
 注意： item高度<frame的高度时设置上下边距才有效果。
 */
@property (nonatomic) UIEdgeInsets sectionInset;

/**
 图片点击的回调
 */
@property (nonatomic, copy) void (^clickBlock)(NSInteger index);


@end
