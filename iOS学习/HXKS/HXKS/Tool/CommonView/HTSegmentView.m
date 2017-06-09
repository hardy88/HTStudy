//
//  HTSegmentView.m
//  hxszy
//
//  Created by hardy on 16/6/24.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import "HTSegmentView.h"


typedef void(^callBack)(NSInteger index);

@interface HTSegmentView ()
{
    UIView *lineView;
    callBack clickIndex;
}
@end

@implementation HTSegmentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self){
    }
    return self;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)setupBasicUI
{
    
}

/**
 set方法重写
 */
-(void)setItems:(NSArray<NSString *> *)items
{
    if (items.count>0)
    {
        NSInteger n = items.count;
        CGFloat w =  self.bounds.size.width / n;
        CGFloat h =  self.bounds.size.height;
        for (int i = 0; i< n; i++)
        {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(w * i, 0, w, h);
            [but setTitle:items[i] forState:UIControlStateNormal];
            but.titleLabel.font = [UIFont systemFontOfSize:17];
            but.tag =  10000 + i;
            [but addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
            [but setTitleColor:[UIColor returnMainTextColor] forState:UIControlStateNormal];
            [self addSubview:but];
        }
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, h-2, w, 2)];
        lineView.backgroundColor = [UIColor returnMainUIColor];
        [self addSubview:lineView];
    }
    _items = items;
}


-(void)actionClick:(UIButton*)but
{
    NSInteger p = but.tag - 10000;
    NSInteger n = _items.count;
    if (n > 0)
    {
        CGFloat w =  self.bounds.size.width / n;
        CGFloat h =  self.bounds.size.height;
        lineView.frame = CGRectMake(p * w, h-2, w, 2);
    }
    clickIndex(but.tag - 10000);
}
- (void)clickButtonIndex:(void (^)(NSInteger index))click
{
    clickIndex = click;
}
@end
