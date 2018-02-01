//
//  UITextField+Extension.h
//  UITextViewDemo
//
//  Created by hardy on 2018/1/31.
//  Copyright © 2018年 Hardy Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设置最大可输入字符数
static NSUInteger MAX_HTTEXTFIELD_CHAR = 10;


@interface UITextField (Extension)


/**
 UITextField添加方法
 UITextField最多只能显示MAX_HTTEXTFIELD_CHAR个字符
 */
-(void)textFieldDidChange;

// 光标位置
- (NSInteger)curOffset;

// 从当前位置偏移
- (void)makeOffset:(NSInteger)offset;

// 从头偏移
- (void)makeOffsetFromBeginning:(NSInteger)offset;

@end
