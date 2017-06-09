//
//  HTMessageCell.m
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTMessageCell.h"
#import "HTSeparator.h"

@interface HTMessageCell ()
{
    UILabel *timeLabel;
    UILabel *contectLabel;
    UILabel *addRessLabel;
    UILabel *telLabel;
}
@end

@implementation HTMessageCell

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
        
        UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(timeLabel.frame), SC_WIDTH-24, 190)];
        cellView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cellView];
        
        CGFloat CELL_WIDTH = CGRectGetWidth(cellView.frame);
        
        UILabel *titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, CELL_WIDTH-24, 50)];
        titelLabel.text = @"接单成功:";
        titelLabel.font = [UIFont systemFontOfSize:20];
        [cellView addSubview:titelLabel];
        
        HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titelLabel.frame), CELL_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cellView addSubview:lineView];
        
        contectLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(lineView.frame)+10, CGRectGetWidth(lineView.frame), 30)];
        contectLabel.font = [UIFont systemFontOfSize:14];
        contectLabel.textColor = [UIColor colorWithHexString:@"#878787"];
        contectLabel.numberOfLines=2;
        [cellView addSubview:contectLabel];
        
        
        addRessLabel =  [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(contectLabel.frame), CGRectGetWidth(lineView.frame), 30)];
        addRessLabel.font = [UIFont systemFontOfSize:14];
        addRessLabel.textColor = [UIColor colorWithHexString:@"#878787"];
        [cellView addSubview:addRessLabel];
        
        telLabel =  [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(addRessLabel.frame), CGRectGetWidth(lineView.frame), 30)];
        telLabel.font = [UIFont systemFontOfSize:14];
        telLabel.textColor = [UIColor colorWithHexString:@"#878787"];
        [cellView addSubview:telLabel];
        
        UILabel *handleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(telLabel.frame), CGRectGetWidth(lineView.frame), 30)];
        handleLabel.text = @"请尽快前往处理";
        handleLabel.font = [UIFont systemFontOfSize:14];
        handleLabel.textColor = [UIColor colorWithHexString:@"#878787"];
        [cellView addSubview:handleLabel];
        
 
    }
    return self;
}

- (void)setModel:(HTMessageSuccessModel *)model
{
    if (model)
    {
        
        timeLabel.text = model.messageTime;
        
        contectLabel.text = [NSString stringWithFormat:@"尊敬的用户您已经成功接受%@的开锁申请。",model.contect];
        addRessLabel.text = [NSString stringWithFormat:@"地址:%@",model.addressStr];
        
        telLabel.text =[NSString stringWithFormat:@"联系电话:%@",model.telStr];
        
    }
}

+ (NSString*)returnCellID
{
    return @"HTMessageCell_CELLID";
}

+ (CGFloat)returnCellHeight
{
    return 230.0f;
}
@end
