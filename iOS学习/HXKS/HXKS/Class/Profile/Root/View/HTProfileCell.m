//
//  HTProfileCell.m
//  HXKS
//
//  Created by hardy on 2017/5/18.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTProfileCell.h"

@interface HTProfileCell ()
{
    UILabel *textLabel;
}
@end

@implementation HTProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SC_WIDTH -24, 60)];
        textLabel.font = [UIFont fontWithName:@"iconfont" size:18];
        textLabel.textColor = [UIColor colorWithHexString:@"#696969"];
        
        [self addSubview:textLabel];
    }
    return self;
}

- (void)setTextStr:(NSString *)textStr
{
    textLabel.text = textStr;
}

@end
