//
//  HTOrderAndNavigationView.m
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTOrderAndNavigationView.h"


@interface HTOrderAndNavigationView ()
{
    UIButton *navBut;
}

@end

@implementation HTOrderAndNavigationView

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
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor colorWithHexString:@"#C2C1C1"].CGColor;
    self.layer.borderWidth=0.5;
    
    UILabel *messsageLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, CGRectGetWidth(self.bounds)-60, CGRectGetHeight(self.bounds))];
    messsageLabel.text = @"您已经成功接单，请尽快上门服务!";
    messsageLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    messsageLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:messsageLabel];
    
    // 导航
    navBut = [UIButton buttonWithType:UIButtonTypeCustom];
    navBut.frame = CGRectMake(CGRectGetWidth(self.frame) - 50, 5, 50, 40);
    navBut.titleLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    [navBut setTitle:@"\ue617" forState:UIControlStateNormal];
    [navBut setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [self addSubview:navBut];
}
- (void)addTarget:(nullable id)target action:(SEL _Nullable )action
{
    [navBut addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end
