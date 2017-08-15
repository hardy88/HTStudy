//
//  HTBanner.m
//  HTBanner
//
//  Created by hardy on 2017/8/15.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTBanner.h"
#import "HTBannerCell.h"

@interface HTBanner ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *clView;
    
    UICollectionViewFlowLayout *flowLayout;
    
    CGSize cellSize;

}

@property(nonatomic,strong)NSMutableArray *dataArr;

@end


@implementation HTBanner

- (instancetype)initWithFrame:(CGRect)frame
                     imageArr:(NSArray*)imageArr
                itemSizeWidth:(CGSize )itemSize
{
    self = [super initWithFrame:frame];
    if (self)
    {
        cellSize = itemSize;
        self.dataArr = [NSMutableArray arrayWithArray:imageArr];
        [self initCollectionViewWithFrame:frame];
    }
    return self;
}
- (void)initCollectionViewWithFrame:(CGRect)rect
{
    
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.itemSize = CGSizeMake(cellSize.width, cellSize.height);
    
    clView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height) collectionViewLayout:flowLayout];
    clView.contentOffset =  CGPointMake(0, 0);
    clView.contentSize = CGSizeMake(cellSize.width  * self.dataArr.count, 0);
    clView.backgroundColor = [UIColor whiteColor];
    clView.dataSource = self;
    clView.delegate = self;
    clView.showsVerticalScrollIndicator = NO;
    clView.showsHorizontalScrollIndicator = NO;
    [clView registerClass:[HTBannerCell class] forCellWithReuseIdentifier:[HTBannerCell cellIdentify]];
    [self  addSubview:clView];
}
- (void)setBackGroundColor:(UIColor *)backGroundColor
{
    clView.backgroundColor = backGroundColor;
}
- (void)setMiniInterItemSpacing:(CGFloat)miniInterItemSpacing
{
    flowLayout.minimumLineSpacing = miniInterItemSpacing;
}
- (void)setMiniLineSpacing:(CGFloat)miniLineSpacing
{
    flowLayout.minimumLineSpacing = miniLineSpacing;
}
- (void)setSectionInset:(UIEdgeInsets)sectionInset
{
    flowLayout.sectionInset = sectionInset;
}
#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HTBannerCell cellIdentify] forIndexPath:indexPath];
    cell.cellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.clickBlock(indexPath.row);
    
}

@end
