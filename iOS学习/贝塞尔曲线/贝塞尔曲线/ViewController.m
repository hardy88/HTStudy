//
//  ViewController.m
//  贝塞尔曲线
//
//  Created by hardy on 2017/6/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import "HTLinePath.h"
#import "HTRectView.h"
// 画文字
#import "HTDrawWorldView.h"
// 画图片
#import "HTDrawImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HTDrawImage *path = [[HTDrawImage alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    path.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:path];

}
- (void)test{
    UIView *rectView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    rectView.backgroundColor = [UIColor redColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rectView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20,5)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = rectView.bounds;
    layer.path = path.CGPath;
    rectView.layer.mask = layer;
    [self.view addSubview:rectView];
}

@end
