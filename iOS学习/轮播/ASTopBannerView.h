//
//  ASTopBannerView.h
//  hxxdj
//
//  Created by hardy on 2017/8/31.
//  Copyright © 2017年 aisino. All rights reserved.
//

/*
 * 广告滚动图
 */


#import "ASBaseView.h"
@class ASTopBannerView;

@protocol ASTopBannerViewDelegate <NSObject>

- (void)ASTopBannerView:(ASTopBannerView*)banner didClickData:(id)data;

- (void)ASTopBannerView:(ASTopBannerView*)banner dicClickIndex:(NSInteger)index;

@end

@interface ASTopBannerView : ASBaseView

@property(nonatomic,weak)id<ASTopBannerViewDelegate> delegate;

@property (nonatomic, copy) NSArray<NSString*> *imgUrls;

@end
