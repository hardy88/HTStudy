//
//  HTButtton.m
//  HTHXBB
//
//  Created by hardy on 2017/3/23.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTButtton.h"

@interface HTButtton ()
{
    UIImageView *imageView;
    
    UILabel *titleLabel;
}
@end

@implementation HTButtton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;//50
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake((w-27)/2, h-54, 27, 27)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:imageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, h-17, w, 17)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:titleLabel];
}

- (void)setImage:(UIImage *)image
{
    if (image)
    {
        imageView.image = image;
    }
}
- (void)setTitle:(NSString *)title
{
    if (title)
    {
        titleLabel.text = title;
    }
}
@end
