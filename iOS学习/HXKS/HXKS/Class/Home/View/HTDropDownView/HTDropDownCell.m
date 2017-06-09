//
//  HTDropDownCell.m
//  HXKS
//
//  Created by hardy on 2017/5/18.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTDropDownCell.h"
#import "HTSeparator.h"

@interface HTDropDownCell ()
{
    UILabel *textLabel;
}
@end

@implementation HTDropDownCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 40)];
        textLabel.textColor = [UIColor colorWithHexString:@"#5E5E5E"];
        textLabel.font = [UIFont fontWithName:@"iconfont" size:14];
        [self addSubview:textLabel];
        
        HTSeparator *lineView  = [[HTSeparator alloc] initWithFrame:CGRectMake(10, 49, 120, 1)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#939395"];
        [self addSubview:lineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setTextTitle:(NSString *)textTitle
{
    textLabel.text = textTitle;
}

@end
