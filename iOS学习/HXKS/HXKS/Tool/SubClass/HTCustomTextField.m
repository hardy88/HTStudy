//
//  HTCustomTextField.m
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTCustomTextField.h"

#import "HTSeparator.h"


#define KWIDTH 40

@implementation HTCustomTextField
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
    
}

-(void)commonInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.clearButtonMode =  UITextFieldViewModeWhileEditing;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0f;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    self.textColor = [UIColor returnMainTextColor];
    self.font = [UIFont systemFontOfSize:15];
    
    HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(0, 39, self.bounds.size.width, 1)];
    [self addSubview:lineView];
}
/*!
 *  修改placeHolder的位置，左右缩进
 *  设置placeHolder的x,y,width,height
 */
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + KWIDTH, bounds.origin.y, bounds.size.width - KWIDTH, bounds.size.height);
}
/*!
 *  修改显示文本的位置
 *  设置编辑完成后文本的x,y,width,height
 */
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + KWIDTH, bounds.origin.y, bounds.size.width - KWIDTH, bounds.size.height);
}
/*!
 *  修改正在编辑状态文本的位置
 *  设置编辑状态文本的x,y,width,height
 */
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + KWIDTH, bounds.origin.y, bounds.size.width - KWIDTH, bounds.size.height);
}
/*!
 *  修改LeftView的位置
 *
 *  设置leftView的x,y,width,height
 */
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake( 8, 10, 30, 30);
    
}


@end
