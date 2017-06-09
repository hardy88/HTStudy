//
//  HTAgreementView.m
//  HXKS
//
//  Created by hardy on 2017/5/18.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTAgreementView.h"


@interface HTAgreementView ()
{
    UIButton *actionBut;
}
@end


@implementation HTAgreementView

- (instancetype _Nullable )initWithFrame:(CGRect)frame andTitle:(NSString *_Nullable)title;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = @"我已阅读并同意";
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
        actionBut = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBut.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, 150, 30);
        [actionBut setTitleColor:[UIColor colorWithHexString:@"#DB2D43"] forState:UIControlStateNormal];
        [actionBut setTitle:title forState:UIControlStateNormal];
        actionBut.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:actionBut];
    }
    return self;
}


- (void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents
{
    [actionBut addTarget:target action:action forControlEvents:controlEvents];
}

@end
