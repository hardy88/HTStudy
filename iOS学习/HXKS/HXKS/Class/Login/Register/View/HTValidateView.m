//
//  HTValidateView.m
//  HXKS
//
//  Created by hardy on 2017/5/18.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTValidateView.h"
#import "HTSeparator.h"


@interface HTValidateView ()
{
    UIButton *but;
}
@end

@implementation HTValidateView


- (instancetype _Nullable )initWithFrame:(CGRect)frame andTitle:(NSString *_Nullable)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height );
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [but setTitle:title forState:UIControlStateNormal];
        [self addSubview:but];
        
        self.backgroundColor = [UIColor colorWithHexString:@"#DB213E"];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(0, 39, self.bounds.size.width, 1)];
        [self addSubview:lineView];
        
    }
    return self;
}


- (void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents
{
    [but addTarget:target action:action forControlEvents:controlEvents];
}

@end
