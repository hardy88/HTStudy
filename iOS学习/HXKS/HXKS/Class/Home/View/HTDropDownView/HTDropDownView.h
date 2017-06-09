//
//  DropDownView.h
//  下拉选项框
//
//  Created by Hardy on 16-1-3.
//  Copyright (c) 2015年 Huawei. All rights reserved.
//


/*
 * 位置导航/取消订单
 */



#import <UIKit/UIKit.h>
/**
 *  函数功能：在视窗上添加一个下拉选项框
 *  注意：1. 用initWithFrame:(CGRect)frame 方法实例化一个DropDownView对象
 *       2. frame中的x和y值决定DropDownView在视窗中的位置, width决定DropDownView的宽度
 *       3. DropDownView 需要被添加到self.view中（如：[self.view addSubview:moreView]）
 **/

@class HTDropDownView;

@protocol DropDownViewDelegate <NSObject>;

-(void)DropDownViewView:(HTDropDownView*)moreActionView selectedItem:(NSInteger)index;

@end

@interface HTDropDownView : UIView

@property (nonatomic,unsafe_unretained)id<DropDownViewDelegate> delegate;
/**
 *  注释：传入数据源数组，创建一个多选选项框
 *
 **/
@property(nonatomic,strong)NSArray *textArr;

/**
 *  注释：隐藏DropDownView
 *
 **/
-(void)destoryDropDownView;

@end
