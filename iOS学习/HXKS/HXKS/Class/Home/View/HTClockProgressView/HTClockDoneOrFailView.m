//
//  HTClockDoneOrFailView.m
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTClockDoneOrFailView.h"

@interface HTClockDoneOrFailView ()
{
    UIButton *doneClik;
    
    UIButton *failClik;
}

@end

@implementation HTClockDoneOrFailView

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
    CGFloat x = 40;
    CGFloat w =(self.bounds.size.width - x*3) /2;

    doneClik= [UIButton buttonWithType:UIButtonTypeCustom];
    doneClik.frame = CGRectMake(x, 0, w,self.bounds.size.height);
    [doneClik setTitle:@"完成开锁" forState:UIControlStateNormal];
    [doneClik setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneClik.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [doneClik setBackgroundColor:[UIColor colorWithHexString:@"#2BC312"]];
    doneClik.layer.masksToBounds = YES;
    doneClik.layer.cornerRadius = 5;
    [self addSubview:doneClik];
    
    failClik = [UIButton buttonWithType:UIButtonTypeCustom];
    failClik.frame = CGRectMake( CGRectGetMaxX(doneClik.frame) + x,0, w, self.bounds.size.height);
    [failClik setTitle:@"开锁失败" forState:UIControlStateNormal];
    [failClik setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    failClik.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [failClik setBackgroundColor:[UIColor colorWithHexString:@"#D00030"]];
    failClik.layer.masksToBounds = YES;
    failClik.layer.cornerRadius = 5;
    [self  addSubview:failClik];
}
// 完成开锁
- (void)addClockDoneTarget:(nullable id)target action:(SEL _Nullable )action
{
    [doneClik addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

// 开锁失败
- (void)addClockDFailTarget:(nullable id)target action:(SEL _Nullable )action
{
    [failClik addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end
