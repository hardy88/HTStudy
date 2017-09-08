//
//  JCTopic.h
//  PSCollectionViewDemo
//
//  Created by jc on 14-1-7.
//
//

#import <UIKit/UIKit.h>
#import "HJManagedImageV.h"
#import "UIImageView+WebCache.h"

@protocol JCTopicDelegate<NSObject>

-(void)didClick:(id)data;
-(void)currentPage:(int)page total:(NSUInteger)total;

@end

@interface JCTopic : UIScrollView<UIScrollViewDelegate>{
    UIButton * pic;
    bool flag;
    int scrollTopicFlag;
    NSTimer * scrollTimer;
    
    CGSize imageSize;
    UIImage *image;
    
    BOOL islabelbackgoundBlack;
    
    @public
    int currentPage;
}

@property(nonatomic,strong)NSArray * pics;
@property(nonatomic,retain)id<JCTopicDelegate> JCdelegate;

- (id)initWithFrame:(CGRect)frame withcolor:(BOOL)color;
- (void)releaseTimer;
- (void)upDate;

@end
