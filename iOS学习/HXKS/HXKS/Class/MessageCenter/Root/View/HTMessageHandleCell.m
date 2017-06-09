//
//  HTMessageHandleCell.m
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTMessageHandleCell.h"
#import "HTSeparator.h"

@interface HTMessageHandleCell ()
{
    
    // 时间
    UILabel *timeLabel;
    
    // 头像
    UIImageView *headerView;
    
    // 备注
    UILabel *detailTextLabel;
    
    // 地址
    UILabel *addressLabel;

}
@end

@implementation HTMessageHandleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor =[UIColor colorWithHexString:@"#ECEBF3"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, 30)];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = [UIColor colorWithHexString:@"#858583"];
        [self addSubview:timeLabel];
        
        
        headerView = [[UIImageView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(timeLabel.frame), 60, 60)];
        headerView.image = [UIImage imageNamed:@"htcat.JPG"];
        headerView.layer.masksToBounds = YES;
        headerView.layer.cornerRadius = 30;
        [self addSubview:headerView];
        
        CGFloat CELL_WIDTH = SC_WIDTH - 84 - 12;
        
        UIView *cellBaseView = [[UIView alloc] initWithFrame:CGRectMake(84, CGRectGetMinY(headerView.frame), CELL_WIDTH, 160)];
        cellBaseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cellBaseView];
        
        UILabel *titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, CELL_WIDTH-24, 50)];
        titelLabel.text = @"请您开锁:";
        titelLabel.font = [UIFont systemFontOfSize:20];
        titelLabel.textColor = [UIColor colorWithHexString:@"#D00C31"];
        [cellBaseView addSubview:titelLabel];
        
        
        detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(titelLabel.frame), CELL_WIDTH-24, 30)];
        detailTextLabel.font = [UIFont systemFontOfSize:14];
        detailTextLabel.textColor = [UIColor colorWithHexString:@"#878787"];
        [cellBaseView addSubview:detailTextLabel];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(detailTextLabel.frame), CELL_WIDTH-24, 30)];
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.textColor = [UIColor colorWithHexString:@"#878787"];
        [cellBaseView addSubview:addressLabel];
        
        
        HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addressLabel.frame)+10, CELL_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cellBaseView addSubview:lineView];
        
        
        UILabel *rightArrowLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELL_WIDTH-30,CGRectGetMaxY(lineView.frame), 30, 40)];
        rightArrowLabel.font = [UIFont fontWithName:@"iconfont" size:18];
        rightArrowLabel.text = @"\ue749";
        [cellBaseView addSubview:rightArrowLabel];
        
        UIButton *checkInfo = [UIButton buttonWithType:UIButtonTypeCustom];
        checkInfo.frame = CGRectMake(12, CGRectGetMaxY(lineView.frame), CELL_WIDTH-24, 40);
        [checkInfo setTitle:@"查看详情" forState:UIControlStateNormal];
        [checkInfo setTitleColor:[UIColor colorWithHexString:@"#979797"] forState:UIControlStateNormal];
        checkInfo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [checkInfo addTarget:self action:@selector(checkInfoClick:) forControlEvents:UIControlEventTouchUpInside];
        [cellBaseView addSubview:checkInfo];
        
    }
    return self;
}

- (void)checkInfoClick:(UIButton*)but
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HTMessageHandleCellCheckDetailInfo)])
    {
        [self.delegate HTMessageHandleCellCheckDetailInfo];
    }
}
- (void)setModel:(HTMessageHandleModel *)model
{
    if (model)
    {
        timeLabel.text = model.messageTime;
        detailTextLabel.text = model.bzStr;
        addressLabel.text = [NSString stringWithFormat:@"地址:%@",model.addStr];
    }
}

+ (NSString*)returnCellID
{
    return @"HTMessageHandleCell_CELLID";
}

+ (CGFloat)returnCellHeight
{
    return 200.0f;
}

@end
