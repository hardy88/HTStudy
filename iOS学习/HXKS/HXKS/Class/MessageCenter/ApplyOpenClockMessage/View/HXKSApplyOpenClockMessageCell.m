//
//  HXKSApplyOpenClockMessageCell.m
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSApplyOpenClockMessageCell.h"

#import "UILabel+AutoFrame.h"

#import "HTSeparator.h"


@interface HXKSApplyOpenClockMessageCell ()
{
    UIButton *clearBut;
    
    UIButton *acceptBut;
}
@end



@implementation HXKSApplyOpenClockMessageCell


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
    self.backgroundColor =[UIColor returnCellBackGroundColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *cellBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SC_WIDTH, 150.5)];
    cellBackGroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cellBackGroundView];
    
    CGFloat cell_width = CGRectGetWidth(cellBackGroundView.frame);
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 40, 40)];
    iconView.image = [UIImage imageNamed:@"htcat.JPG"];
    [cellBackGroundView addSubview:iconView];
    
    CGFloat x_frame = CGRectGetMaxX(iconView.frame) + 5;
    CGFloat y_frame = 5;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_frame, y_frame, 100, 20)];
    titleLabel.text = @"申请开锁";
    CGSize size = [titleLabel getCgsizeWithTitle:titleLabel.text textFont:14 maxCgsize:CGSizeMake(CGFLOAT_MAX, 20)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.frame = CGRectMake(x_frame, y_frame, size.width, 20);
    [cellBackGroundView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_frame, CGRectGetMaxY(titleLabel.frame), 0, 20)];
    timeLabel.text = @"下午 04:22";
    CGSize tiemSize = [timeLabel getCgsizeWithTitle:timeLabel.text textFont:14 maxCgsize:CGSizeMake(CGFLOAT_MAX, 20)];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.frame = CGRectMake(x_frame, CGRectGetMaxY(titleLabel.frame), tiemSize.width, 20);
    [cellBackGroundView addSubview:timeLabel];
    
    clearBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearBut setTitle:@"\ue69a" forState:UIControlStateNormal];
    clearBut.titleLabel.font = [UIFont fontWithName:@"iconfont" size:18];
    [clearBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clearBut.frame = CGRectMake(cell_width - 40, 0, 40, 40);
    [clearBut addTarget:self action:@selector(clearClick:) forControlEvents:UIControlEventTouchUpInside];
    [cellBackGroundView addSubview:clearBut];
    
    HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(12, CGRectGetMinX(timeLabel.frame) , cell_width - 12, 0.5)];
    [cellBackGroundView addSubview:lineView];
    
    
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_frame, CGRectGetMaxY(lineView.frame) + 10, cell_width - x_frame, 20)];
    addLabel.text = @"地址：安顺家园";
    [cellBackGroundView addSubview:addLabel];
    
    UILabel *applyLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_frame, CGRectGetMaxY(addLabel.frame), cell_width - x_frame, 20)];
    applyLabel.text = @"申请人：张先生";
    [cellBackGroundView addSubview:applyLabel];
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_frame, CGRectGetMaxY(applyLabel.frame), cell_width - x_frame, 20)];
    telLabel.text = @"联系电话：15698742361";
    [cellBackGroundView addSubview:telLabel];
    
    acceptBut = [UIButton buttonWithType:UIButtonTypeCustom];
    acceptBut.frame = CGRectMake(0, CGRectGetMaxY(telLabel.frame), cell_width, 30);
    acceptBut.backgroundColor = [UIColor colorWithHexString:@"#CBD0E4"];
    [acceptBut setTitle:@"接受申请" forState:UIControlStateNormal];
    [acceptBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [acceptBut addTarget:self action:@selector(acceptApply:) forControlEvents:UIControlEventTouchUpInside];
    [cellBackGroundView addSubview:acceptBut];
}
- (void)setIndex:(NSInteger)index
{
    clearBut.tag = 1000+index;
    acceptBut.tag = 2000+index;
}


+ (CGFloat)returnCellHight;
{
    return 165.5f;
}
+ (NSString *)returnCellId
{
    return @"HXKSApplyOpenClockMessageCell_id";
}

- (void)clearClick:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HXKSApplyOpenClockMessageCellClear:)])
    {
        [self.delegate HXKSApplyOpenClockMessageCellClear:sender.tag - 1000];
    }
}

- (void)acceptApply:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HXKSApplyOpenClockMessageCellAcceptApply:)])
    {
        [self.delegate HXKSApplyOpenClockMessageCellAcceptApply:sender.tag - 2000];
    }
}

@end
