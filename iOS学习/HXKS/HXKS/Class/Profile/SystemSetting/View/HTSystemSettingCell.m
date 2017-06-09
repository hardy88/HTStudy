//
//  HTSystemSettingCell.m
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTSystemSettingCell.h"

@interface HTSystemSettingCell ()
{
    UILabel *textLabel;
}
@end

@implementation HTSystemSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 60)];
        [self addSubview:textLabel];
    }
    return self;
}

- (void)setTextStr:(NSString *)textStr
{
    textLabel.text = textStr;
}
+ (CGFloat)returnCellHeight
{
    return 60.0f;
}

@end
