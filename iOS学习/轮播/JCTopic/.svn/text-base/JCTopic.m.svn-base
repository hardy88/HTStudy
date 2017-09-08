//
//  JCTopic.m
//  PSCollectionViewDemo
//
//  Created by jc on 14-1-7.
//
//

#import "JCTopic.h"

@implementation JCTopic
@synthesize JCdelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setSelf];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withcolor:(BOOL)color
{
    self = [super initWithFrame:frame];
    if (self) {
        islabelbackgoundBlack=color;
        self.frame = frame;
        [self setSelf];
        
        UIImageView *imageview=[[UIImageView alloc] initWithFrame:frame];
        imageview.image=[UIImage imageNamed:@"grayColor.png"];
        [self addSubview:imageview];
    }
    return self;
}

-(void)setSelf{
    self.pagingEnabled = YES;
    self.scrollEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setSelf];
    
    // Drawing code
}
-(void)upDate{
    NSMutableArray *tempImageArray = [[NSMutableArray alloc]init];
    if (self.pics.count > 0) {
        [tempImageArray addObject:[self.pics lastObject]];
        for (id obj in self.pics) {
            [tempImageArray addObject:obj];
        }
        [tempImageArray addObject:[self.pics objectAtIndex:0]];
        self.pics = Nil;
        self.pics = tempImageArray;
        
        int i = 0;
        for (id obj in self.pics) {
            pic= Nil;
            pic = [UIButton buttonWithType:UIButtonTypeCustom];
            pic.imageView.contentMode = UIViewContentModeTop;
            [pic setFrame:CGRectMake(i*self.frame.size.width,0, self.frame.size.width, self.frame.size.height)];
            
            //        HJManagedImageV *hjimagev=[[HJManagedImageV alloc]initWithFrame:CGRectMake(0, 0, pic.frame.size.width, pic.frame.size.height)];
            
            UIImageView * tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
            [tempImage setClipsToBounds:YES];
            [tempImage sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:nil];
            [pic addSubview:tempImage];
            [pic setBackgroundColor:[UIColor grayColor]];
            pic.tag = i;
            [pic addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pic];
                  i ++;
        }
        [self setContentSize:CGSizeMake(self.frame.size.width*[self.pics count], self.frame.size.height)];
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        
        if (scrollTimer) {
            [scrollTimer invalidate];
            scrollTimer = nil;
            
        }
        if ([self.pics count]>3) {
            self.scrollEnabled=YES;
            scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
        }
        else{
            self.scrollEnabled=NO;
        }
    }
}

-(void)click:(id)sender{
    if ([sender isKindOfClass:[UIView class]]) {
        UIView *v = (UIView*)sender;
        [JCdelegate didClick:v];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat Width=self.frame.size.width;
    if (scrollView.contentOffset.x == self.frame.size.width) {
        flag = YES;
    }
    if (flag) {
        if (scrollView.contentOffset.x <= 0) {
            [self setContentOffset:CGPointMake(Width*([self.pics count]-2), 0) animated:NO];
        }else if (scrollView.contentOffset.x >= Width*([self.pics count]-1)) {
            [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        }
    }
    currentPage = scrollView.contentOffset.x/self.frame.size.width-1;
    [JCdelegate currentPage:currentPage total:[self.pics count]-2];
    scrollTopicFlag = currentPage+2==2?2:currentPage+2;
}

-(void)scrollTopic{
    [self setContentOffset:CGPointMake(self.frame.size.width*scrollTopicFlag, 0) animated:YES];
    
    if (scrollTopicFlag > [self.pics count]) {
        scrollTopicFlag = 1;
    }else {
        scrollTopicFlag++;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:6.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
    }
    
}

-(void)releaseTimer{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
        
    }
}

@end
