//
//  HTUploadImageCell.m
//  HXKS
//
//  Created by hardy on 2017/5/22.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTUploadImageCell.h"
#import "HTSeparator.h"


@interface HTUploadImageCell ()
{
    
    UIButton *addImageBut;
    
    UILabel *orderInfoLabel;
}
@end

@implementation HTUploadImageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self comitUI];
    }
    return self;
}

- (void)comitUI
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat blank = 12;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 4 * blank) /3;

    
    orderInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SC_WIDTH-24, 60)];
    orderInfoLabel.text = @"资料信息上传:";
    orderInfoLabel.textColor = [UIColor colorWithHexString:@"#D0002C"];
    orderInfoLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:orderInfoLabel];
    
    HTSeparator *lineView = [[HTSeparator alloc] initWithFrame:CGRectMake(12, 59, CGRectGetWidth(orderInfoLabel.frame)-12, 1)];
    [self addSubview:lineView];
    
    addImageBut = [UIButton buttonWithType:UIButtonTypeCustom];
    addImageBut.frame = CGRectMake(12, 70, width, width);
    addImageBut.titleLabel.font = [UIFont fontWithName:@"iconfont" size:width];
    addImageBut.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [addImageBut setTitle:@"\ue6de" forState:UIControlStateNormal];
    [addImageBut setTitleColor:[UIColor colorWithHexString:@"#A4A4A4"] forState:UIControlStateNormal];
    [addImageBut addTarget:self action:@selector(loadMoreImage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addImageBut];
    
    UILabel *docProveLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(addImageBut.frame)+10, self.bounds.size.width, 30)];
    docProveLabel.text = @"(注:门锁需要房产证或租住合同或水电缴费单)";
    docProveLabel.textColor = [UIColor colorWithHexString:@"#CD0005"];
    docProveLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:docProveLabel];
}

- (void)setImgArr:(NSMutableArray *)imgArr
{
    if (imgArr.count > 0)
    {
        CGFloat blank = 12;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 4 * blank) /3;
        for (int i = 0; i< imgArr.count; i++)
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12 *( i % 3 +1) + width * (i%3),70, width, width)];
            imgView.image = imgArr[i];
            
            [self addSubview:imgView];
        }
        if (imgArr.count>=2)
        {
            [addImageBut removeFromSuperview];
        }
        else
        {
           addImageBut.frame = CGRectMake( 12 *(imgArr.count+1) + width*imgArr.count, 70, width, width);
        }
    }
}

+ (CGFloat)returnCellHeight
{
    return 220.0f;
}

+ (NSString*)returnCellID
{
    return @"HTUploadImageCell_id";
}

- (void)loadMoreImage:(UIButton*)but
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(htUploadImageCellloadMoreImage)])
    {
        [self.delegate htUploadImageCellloadMoreImage];
    }
}
@end
