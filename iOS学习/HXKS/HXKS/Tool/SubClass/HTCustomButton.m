//
//  HTCustomButton.m
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTCustomButton.h"

@implementation HTCustomButton

-(void)customButtonByTitle:(NSString*)title Ypoint:(CGFloat)yPoint FontSize:(CGFloat)fontSize
{
    [self setTitle:title forState:UIControlStateNormal];
    self.frame = CGRectMake(12, yPoint, [UIScreen mainScreen].bounds.size.width - 24, 40);
    self.backgroundColor = [UIColor colorWithHexString:@"#DB213E"];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}
@end
