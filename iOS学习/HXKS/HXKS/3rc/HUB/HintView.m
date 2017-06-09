//
//  HintView.m
//  HomeLinked
//
//  Created by OSX102 on 15-3-27.
//  Copyright (c) 2015年 Huawei. All rights reserved.
//

#import "HintView.h"

@interface HintView ()
{
    NSTimer*timer;
}
@end

@implementation HintView

-(instancetype)initWith:(NSString*)message
{
    self=[super init];
    if(self)
    {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.layer.cornerRadius=10;
        self.layer.masksToBounds=YES;
        UILabel*label=[[UILabel alloc]init];
        label.numberOfLines=0;
        label.textAlignment=NSTextAlignmentLeft;
//        label.font=[UIFont fontWithName:CUSTOM_FONT_NAME size:12];
        label.backgroundColor=[UIColor colorWithWhite:255 alpha:0];
        label.textColor=[UIColor whiteColor];
        label.text=message;
        //屏幕size
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        //view最大宽度
        float maxWidth=screenSize.width-100;
        
        //高度固定不折行，根据字的多少计算label的宽度
        CGSize sizeW = [message sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 0)];
        //宽度不变，根据字的多少计算label的高度
        CGSize sizeH = [message sizeWithFont:label.font constrainedToSize:CGSizeMake(maxWidth-40, MAXFLOAT)];
        //未达到限制宽度
        if(sizeW.width<maxWidth-40)
        {
            [self setFrame:CGRectMake((screenSize.width-sizeW.width)/2-20, screenSize.height-120, sizeW.width+40, sizeW.height+16)];
            [label setFrame:CGRectMake(20, 8, sizeW.width, sizeW.height)];
        }
        else
        {
            [self setFrame:CGRectMake((screenSize.width-sizeH.width)/2-20, screenSize.height-120,sizeH.width+40, sizeH.height+16)];
            [label setFrame:CGRectMake(20, 8, sizeH.width, sizeH.height)];
        }
        [self addSubview:label];
    }
    return self;
}
-(void)showInView:(UIView*)view
{
    self.layer.opacity=0;
    [view addSubview:self];
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.layer.opacity=1;
     }completion:^(BOOL finish){}];
    timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(miss) userInfo:nil repeats:NO];
}
-(void)miss
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.layer.opacity=0;
     }completion:^(BOOL finish)
    {
        [self removeFromSuperview];
    }];
}
@end
