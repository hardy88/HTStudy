//
//  ASTopBannerView.m
//  hxxdj
//
//  Created by hardy on 2017/8/31.
//  Copyright © 2017年 aisino. All rights reserved.
//

// view
#import "ASTopBannerView.h"
#import "JCTopic.h"


@interface ASTopBannerView ()<JCTopicDelegate>

@property(nonatomic,strong)JCTopic *jcView;

@property (nonatomic, strong) UIPageControl *pageCtr;

@end


@implementation ASTopBannerView
@synthesize jcView;
@synthesize pageCtr;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        jcView = [[JCTopic alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) withcolor:NO];
        jcView.JCdelegate = self;
        [self addSubview:jcView];
        
        pageCtr = [[UIPageControl alloc]init];
        pageCtr.pageIndicatorTintColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
        pageCtr.currentPageIndicatorTintColor = [UIColor colorWithRed:29.0/255.0 green:164.0/255.0 blue:252.0/255.0 alpha:1.0];
        pageCtr.center = CGPointMake(self.center.x, CGRectGetMaxY(self.frame) - 10);
        [self addSubview:pageCtr];        
    }
    return self;
}

- (void)setImgUrls:(NSArray<NSString *> *)imgUrls
{
    if (imgUrls.count > 0)
    {
        pageCtr.numberOfPages = imgUrls.count;
        jcView.pics = imgUrls;
        [jcView upDate];
    }
}

#pragma mark JCTopicDelegate
-(void)didClick:(id)data
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ASTopBannerView:didClickData:)])
    {
        [self.delegate ASTopBannerView:self didClickData:data];
    }
}
-(void)currentPage:(int)page total:(NSUInteger)total
{
    pageCtr.currentPage = page;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ASTopBannerView:dicClickIndex:)])
    {
        [self.delegate ASTopBannerView:self dicClickIndex:page];
    }
}


@end
