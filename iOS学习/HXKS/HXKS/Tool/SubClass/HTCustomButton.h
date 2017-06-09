//
//  HTCustomButton.h
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*!
 *  自定义Button
 */


#import <UIKit/UIKit.h>

@interface HTCustomButton : UIButton

/*!
 *  根据Y轴坐标快速创建一个固定的Button
 *
 *  @param title    title
 *  @param yPoint   y轴坐标
 *  @param fontSize 字体大小
 
 例子：
 *  CustomUIButton *but = [CustomUIButton buttonWithType:UIButtonTypeCustom];
 *  [but customButtonByTitle:@"按钮" Ypoint:64 FontSize:FONT_SIZE_14PT];
 */
-(void)customButtonByTitle:(NSString*)title Ypoint:(CGFloat)yPoint FontSize:(CGFloat)fontSize;
/*!
 *  根据文字宽度获取button 大小
 *
 *  @param maxWidth 最大宽度
 *  @param text     title
 *
 *  @return <#return value description#>
 */
-(CGSize)getSizeWithCustomButtonMaxWidth:(NSInteger)maxWidth titel:(NSString*)text;
/*!
 *  根据文字宽度和字体大小获取button大小
 *
 *  @param maxWidth 最大宽度
 *  @param text     title
 *  @param fontSize 字体大小
 *
 *  @return
 */
-(CGSize)getSizeWithCustomButtonMaxWidth:(NSInteger)maxWidth titel:(NSString*)text font:(CGFloat)fontSize;

@end
