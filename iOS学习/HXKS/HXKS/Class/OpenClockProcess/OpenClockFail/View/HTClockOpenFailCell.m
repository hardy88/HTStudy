//
//  HTClockOpenFailCell.m
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTClockOpenFailCell.h"
#import "HTSeparator.h"

@interface HTClockOpenFailCell ()<UITextViewDelegate>
{
    UILabel *reasonLabel;
    UITextView *txView; // 原因填写
}
@end

@implementation HTClockOpenFailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self comitUI];
    }
    return self;
}

- (void)comitUI
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    reasonLabel  = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SC_WIDTH-24, 60)];
    reasonLabel.text = @"原因:";
    reasonLabel.textColor = [UIColor colorWithHexString:@"#D0002C"];
    reasonLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:reasonLabel];
    
    HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(12, 59, CGRectGetWidth(reasonLabel.frame)-12, 1)];
    [self addSubview:lineView];
    
    txView = [[UITextView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(reasonLabel.frame), CGRectGetWidth(reasonLabel.frame), 160)];
    txView.text = @"说说没打开的原因...";
    txView.font = [UIFont systemFontOfSize:17];
    txView.textColor = [UIColor lightGrayColor];
    txView.delegate = self;
    [self addSubview:txView];
}

+ (CGFloat)returnCellHeight
{
    return 220.0f;
}

+ (NSString*)returnCellID
{
    return @"HTClockOpenFailCell_CELLID";
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@""]  || [textView.text isEqualToString:@"说说没打开的原因..."])
    {
        txView.text = @"" ;
        txView.textColor = [UIColor blackColor];
    }
    
   
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@""])
    {
        txView.text = @"说说没打开的原因...";
        txView.textColor = [UIColor lightGrayColor];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(htClockOpenFailCell:editText:)])
        {
            [self.delegate htClockOpenFailCell:self editText:txView.text];
        }
    }
   
}
@end
