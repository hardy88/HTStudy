//
//  HTCustomerDetailInfoView.m
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTCustomerDetailInfoView.h"

@interface HTCustomerDetailInfoView ()
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
    // 距离
    UILabel *desLabel;
    // 发布时间间隔
    UILabel *jgLabel;
}
@end

@implementation HTCustomerDetailInfoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self comitUI];
    }
    return self;
}
- (void)comitUI
{
    applyer = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, self.bounds.size.width - 12, 30)];
    applyer.font = [UIFont systemFontOfSize:14];
    [self addSubview:applyer];
    
    telNum = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(applyer.frame), CGRectGetWidth(applyer.frame), CGRectGetHeight(applyer.frame))];
    telNum.font = [UIFont systemFontOfSize:14];
    [self addSubview:telNum];
    
    address = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(telNum.frame), CGRectGetWidth(telNum.frame), CGRectGetHeight(applyer.frame))];
    address.font = [UIFont systemFontOfSize:14];
    [self addSubview:address];
    
    hasLock = [[UILabel alloc]  initWithFrame:CGRectMake(12, CGRectGetMaxY(address.frame), CGRectGetWidth(address.frame), CGRectGetHeight(applyer.frame))];
    hasLock.font = [UIFont systemFontOfSize:14];
    [self addSubview:hasLock];
    
    lockType = [[UILabel alloc]  initWithFrame:CGRectMake(12, CGRectGetMaxY(hasLock.frame), CGRectGetWidth(hasLock.frame), CGRectGetHeight(applyer.frame))];
    lockType.font = [UIFont systemFontOfSize:14];
    [self addSubview:lockType];
    
    desLabel = [[UILabel alloc]  initWithFrame:CGRectMake(12, CGRectGetMaxY(lockType.frame), CGRectGetWidth(lockType.frame), CGRectGetHeight(applyer.frame))];
    desLabel.font = [UIFont systemFontOfSize:14];
    desLabel.textColor = [UIColor redColor];
    [self addSubview:desLabel];
    
    jgLabel = [[UILabel alloc]  initWithFrame:CGRectMake(110, CGRectGetMaxY(lockType.frame), CGRectGetWidth(lockType.frame), CGRectGetHeight(applyer.frame))];
    jgLabel.font = [UIFont systemFontOfSize:14];
    jgLabel.textColor = [UIColor redColor];
    [self addSubview:jgLabel];
}
- (void)setModel:(HTCustomerInfoModel *)model
{
    if (model)
    {
        applyer.text = [NSString stringWithFormat:@"申请人:%@",model.applyStr];
        telNum.text = [NSString stringWithFormat:@"联系方式:%@",model.telStr];
        address.text = [NSString stringWithFormat:@"地址:%@",model.addStr];
        hasLock.text = [NSString stringWithFormat:@"有无反锁:%@",model.hasLock ? @"有":@"无"];
        if ([model.lockType  isEqual: @0])
        {
            lockType.text = @"锁芯类型:A类";
        }
        else if ([model.lockType  isEqual: @1])
        {
            lockType.text = @"锁芯类型:B类";
        }
        else if ([model.lockType  isEqual: @2])
        {
            lockType.text = @"锁芯类型:C类";
        }
        desLabel.text =  [NSString stringWithFormat:@"距您%@km",model.desStr];;
        jgLabel.text = [NSString stringWithFormat:@"%@发布",model.timeStr];
    }
}


@end
