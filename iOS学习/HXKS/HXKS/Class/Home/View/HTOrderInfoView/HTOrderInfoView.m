//
//  HTOrderInfoView.m
//  HXKS
//
//  Created by hardy on 2017/5/23.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTOrderInfoView.h"
#import "HTSeparator.h"
#import "HTGetOrderInfoView.h"


@interface HTOrderInfoView ()
{
    // 关闭按钮
    UIButton *closeBut;
    // 抢单按钮
    UIButton *qdBut;
    // 订单详情
    HTGetOrderInfoView *detailInfoView;
}

@end

@implementation HTOrderInfoView

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
    self.backgroundColor = [UIColor customColorWithRed:0 green:0 blue:0 alpha:0.3];
    
    UIView *verLine = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width-2)/2, 0, 2, self.bounds.size.height/2  - 160)];
    verLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:verLine];
    
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width *3/ 5, 320)];
    infoView.center = self.center;
    infoView.layer.masksToBounds = YES;
    infoView.layer.cornerRadius = 5.0f;
    infoView.backgroundColor = [UIColor whiteColor];
    [self addSubview:infoView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(infoView.frame), 40)];
    titleLabel.backgroundColor = [UIColor colorWithHexString:@"#2ABC13"];
    titleLabel.text = @"已接单";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [infoView addSubview:titleLabel];
    
    closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBut.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)-30, 5, 30, 30);
    closeBut.titleLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    [closeBut setTitle:@"\ue69a" forState:UIControlStateNormal];
    [closeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [infoView addSubview:closeBut];
    
    CGFloat bank = 10;
    CGFloat width =(CGRectGetWidth(infoView.frame)-40)/3;
    for (int i = 0; i <3; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(bank * (i+1)+ i *width, CGRectGetMaxY(titleLabel.frame) + 10, width, width)];
        imgView.image = [UIImage imageNamed:@"htHeader.png"];
        imgView.layer.borderColor = [UIColor redColor].CGColor;
        imgView.layer.borderWidth = 0.5f;
        [infoView addSubview:imgView];
    }
    
    
    HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(bank,CGRectGetMaxY(titleLabel.frame) + 20 + width,CGRectGetWidth(infoView.frame) - 2*bank, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"BABABA"];
    [infoView addSubview:lineView];
    
    
    
    detailInfoView = [[HTGetOrderInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame) + 10, CGRectGetWidth(infoView.frame), 180)];
    [infoView addSubview:detailInfoView];

}
- (void)setModel:(HTCustomerInfoModel *)model
{
    if (model)
    {
        detailInfoView.model = model;
    }
}
- (void)addCloseTarget:(nullable id)target action:(SEL _Nullable )action
{
    [closeBut addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
