//
//  HTBannerCell.m
//  HTBanner
//
//  Created by hardy on 2017/8/15.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTBannerCell.h"

@implementation HTBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _cellImage = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self addSubview:_cellImage];
        
    }
    return self;
}
+ (NSString*)cellIdentify
{
    return @"HTBannerCell_id";
}

@end
