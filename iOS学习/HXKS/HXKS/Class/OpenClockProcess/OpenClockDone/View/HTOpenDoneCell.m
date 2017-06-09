//
//  HTOpenDoneCell.m
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTOpenDoneCell.h"
#import "HTSeparator.h"

@interface HTOpenDoneCell ()
{
    // 申请人
    UILabel *applyer;
    // 联系方式
    UILabel *telNum;
    // 地址
    UILabel *address;
    // 有无反锁
    UILabel *hasLock;
    // 锁芯类型
    UILabel *lockType;
    // 完成时间
    UILabel *doneTime;
}
@end


@implementation HTOpenDoneCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *orderInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SC_WIDTH-24, 60)];
        orderInfoLabel.text = @"订单信息:";
        orderInfoLabel.textColor = [UIColor colorWithHexString:@"#D0002C"];
        orderInfoLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:orderInfoLabel];
        
        HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(12, 59, CGRectGetWidth(orderInfoLabel.frame)-12, 1)];
        [self addSubview:lineView];
        
        
        applyer = [[UILabel alloc] initWithFrame:CGRectMake(12, 60, [UIScreen mainScreen].bounds.size.width - 12, 30)];
        applyer.font= [UIFont systemFontOfSize:14];
        [self addSubview:applyer];
        
        telNum = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(applyer.frame), CGRectGetWidth(applyer.frame), CGRectGetHeight(applyer.frame))];
        telNum.font= [UIFont systemFontOfSize:14];
        [self addSubview:telNum];
        
        address = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(telNum.frame), CGRectGetWidth(telNum.frame), CGRectGetHeight(applyer.frame))];
        address.font= [UIFont systemFontOfSize:14];
        [self addSubview:address];
        
        hasLock = [[UILabel alloc]  initWithFrame:CGRectMake(12, CGRectGetMaxY(address.frame), CGRectGetWidth(address.frame), CGRectGetHeight(applyer.frame))];
        hasLock.font= [UIFont systemFontOfSize:14];
        [self addSubview:hasLock];
        
        lockType = [[UILabel alloc]  initWithFrame:CGRectMake(12, CGRectGetMaxY(hasLock.frame), CGRectGetWidth(hasLock.frame), CGRectGetHeight(applyer.frame))];
        lockType.font= [UIFont systemFontOfSize:14];
        [self addSubview:lockType];
        
        doneTime = [[UILabel alloc]  initWithFrame:CGRectMake(12, CGRectGetMaxY(lockType.frame), CGRectGetWidth(lockType.frame), CGRectGetHeight(applyer.frame))];
        doneTime.font= [UIFont systemFontOfSize:14];
        [self addSubview:doneTime];
        
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)configCellWithModel:(HTOpenClockOrderModel*)model
{
    applyer.text = [NSString stringWithFormat:@"申请人:%@",model.applyer];
    telNum.text = [NSString stringWithFormat:@"联系方式:%@",model.telStr];
    address.text = [NSString stringWithFormat:@"地址:%@",model.addStr];
    if (model.hsaLock)
    {
        hasLock.text = @"有无反锁:有";
    }
    else
    {
        hasLock.text = @"有无反锁:无";
    }
    switch ([model.lockType intValue])
    {
        case 0:
            lockType.text = [NSString stringWithFormat:@"锁芯类型:%@",@"A类"];
            break;
        case 1:
            lockType.text = [NSString stringWithFormat:@"锁芯类型:%@",@"B类"];
            break;
        case 2:
            lockType.text = [NSString stringWithFormat:@"锁芯类型:%@",@"C类"];
            break;
        default:
            break;
    }
    doneTime.text = model.timeStr;
}
+ (CGFloat)returnCellHeight
{
    return 240.0f;
}
+ (NSString*)returnCellID
{
    return @"HTOpenDoneCell_id";
}
@end
