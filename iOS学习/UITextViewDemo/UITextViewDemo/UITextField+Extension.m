//
//  UITextField+Extension.m
//  UITextViewDemo
//
//  Created by hardy on 2018/1/31.
//  Copyright © 2018年 Hardy Hu. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>

@implementation UITextField (Extension)

-(void)textFieldDidChange
{
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
//- (void)dealloc
//{
//    [self removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//}
- (void)textFieldDidChange:(UITextField *)textField
{
//    NSString *lang = textField.textInputMode.primaryLanguage;//键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"]) //中文
//    {
        UITextRange *selectedRange = [self markedTextRange];
        if (!selectedRange)
        {   //无高亮
            if (textField.text.length > MAX_HTTEXTFIELD_CHAR)
            {
                textField.text = [textField.text substringToIndex:MAX_HTTEXTFIELD_CHAR];
            }
        }
//    }
}

- (NSInteger)curOffset
{
    // 基于文首计算出到光标的偏移数值。
    return [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
}

- (void)makeOffset:(NSInteger)offset{
    
    // 实现原理是先获取一个基于文尾的偏移，然后加上要施加的偏移，再重新根据文尾计算位置，最后利用选取来实现光标定位。
    UITextRange *selectedRange = [self selectedTextRange];
    NSInteger currentOffset = [self offsetFromPosition:self.endOfDocument toPosition:selectedRange.end];
    currentOffset += offset;
    UITextPosition *newPos = [self positionFromPosition:self.endOfDocument offset:currentOffset];
    self.selectedTextRange = [self textRangeFromPosition:newPos toPosition:newPos];
}

- (void)makeOffsetFromBeginning:(NSInteger)offset{
    
    // 先把光标移动到文首，然后再调用上面实现的偏移函数。
    UITextPosition *begin = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:begin offset:0];
    UITextRange *range = [self textRangeFromPosition:start toPosition:start];
    [self setSelectedTextRange:range];
    [self makeOffset:offset];
    
}

/**
 修改UITextField的响应范围

 @param point 被点击的点坐标
 @param event 点击事件
 @return 被点击的点是否在该控件范围内
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%@", [event allTouches]);
    
    if ([self isMemberOfClass:[UITextField class]])
    {
        // 这个范围需要自己改为实际需求，一般是往外扩大3px
        CGRect rect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width/2, self.bounds.size.height);
        // 通过修改该控件的范围达到改变该控件是否响应该点的点击
        return CGRectContainsPoint(rect, point) ? YES : NO;
    }
    return [super pointInside:point withEvent:event];
}

@end
