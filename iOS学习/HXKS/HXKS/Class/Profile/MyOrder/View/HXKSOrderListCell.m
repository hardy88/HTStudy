//
//  HXKSOrderListCell.m
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSOrderListCell.h"
#import "HTSeparator.h"
#import "UILabel+AutoFrame.h"

@implementation HXKSOrderListCell


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
    
    self.backgroundColor =[UIColor colorWithHexString:@"#ECEBF3"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *cellBackGround = [[UIView alloc] initWithFrame:CGRectMake(12,10, SC_WIDTH-24, 224.5)];
    cellBackGround.backgroundColor = [UIColor whiteColor];
    [self addSubview:cellBackGround];
    
    CGFloat cellWidth = CGRectGetWidth(cellBackGround.frame);
    UILabel *orderTitleTime = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, cellWidth-24, 50)];
    orderTitleTime.text = @"2017-05-01 16:48";
    [cellBackGround addSubview:orderTitleTime];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    CGSize size = [statusLabel getCgsizeWithTitle:@"已完成" textFont:17.0 maxCgsize:CGSizeMake(CGFLOAT_MAX, 50)];
    statusLabel.frame = CGRectMake(cellWidth - size.width-12, 0, size.width, 50);
    statusLabel.text = @"已完成";
    statusLabel.textColor = [UIColor redColor];
    [cellBackGround  addSubview:statusLabel];
    
    HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(orderTitleTime.frame), cellWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cellBackGround addSubview:lineView];
    
    UILabel *orderNum = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(lineView.frame) + 12, cellWidth-12, 30)];
    orderNum.text = @"订单编号：42010620170501162242";
    orderNum.textColor = [UIColor colorWithHexString:@"#878787"];
    [cellBackGround addSubview:orderNum];
    
    UILabel *openClockAdd =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(orderNum.frame), CGRectGetMaxY(orderNum.frame), CGRectGetWidth(orderNum.frame),CGRectGetHeight(orderNum.frame))];
    openClockAdd.text = @"开锁地址: 安顺家园";
    openClockAdd.textColor = [UIColor colorWithHexString:@"#878787"];
    [cellBackGround addSubview:openClockAdd];
    
    
    UILabel *applyer =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(openClockAdd.frame), CGRectGetMaxY(openClockAdd.frame), CGRectGetWidth(openClockAdd.frame),CGRectGetHeight(openClockAdd.frame))];
    applyer.text = @"申请人: 张先生";
    applyer.textColor = [UIColor colorWithHexString:@"#878787"];
    [cellBackGround addSubview:applyer];
    
    
    UILabel *molbyPhone =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(applyer.frame), CGRectGetMaxY(applyer.frame), CGRectGetWidth(applyer.frame),CGRectGetHeight(applyer.frame))];
    molbyPhone.text = @"移动电话: 13868689696";
    molbyPhone.textColor = [UIColor colorWithHexString:@"#878787"];
    [cellBackGround addSubview:molbyPhone];
    
    
    UILabel *acceptTime =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(molbyPhone.frame), CGRectGetMaxY(molbyPhone.frame), CGRectGetWidth(molbyPhone.frame),CGRectGetHeight(molbyPhone.frame))];
    acceptTime.text = @"接受时间: 2017-05-01 14:25";
    acceptTime.textColor = [UIColor colorWithHexString:@"#878787"];
    [cellBackGround addSubview:acceptTime];
    
}
+ (NSString*)cellIdentify
{
    return @"HXKSOrderListCell_ID";
}


+ (CGFloat)cellHight
{
    return 234.5f;
}

@end
