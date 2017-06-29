//
//  ViewController.m
//  画心形
//
//  Created by hardy on 16/5/19.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"
#import "HTHeartView.h"
#import "HTArcView.h"
#import "HTTringleView.h"

@interface ViewController ()
{
    UIView *view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

//    HTTringleView *VC = [[HTTringleView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49 - [UIScreen mainScreen].bounds.size.width/5,  [UIScreen mainScreen].bounds.size.width, 49 + [UIScreen mainScreen].bounds.size.width/5)];
//   
//    [self.view addSubview:VC];
    
    HTHeartView *hview = [[HTHeartView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.view addSubview:hview];
    

}
-(void)test
{
    /*!
     *  利用CAShapeLayer帮忙画出来的图形都是实心的
     *
     *  改写UIView的DrawRect方法中，贝塞尔曲线画出来的是一个路径，非实心的。
     *  
     *  如果在DrawRect方法外，还需要去改图画，则需要调用一次setNeedsDisplay,类似于TableView的reloadData效果。
     */
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineView];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    CGFloat  radius =MIN(100 / 4, 100 / 4);
    
    
    CGFloat w =  view.frame.size.width /4 ;
    //左半圆
    UIBezierPath *path  =[UIBezierPath bezierPathWithArcCenter:CGPointMake(w, w) radius:radius startAngle:M_PI endAngle:0 clockwise:YES];
    //    UIBezierPath *path =[UIBezierPath bezierPath];
    // 右半圆
    [ path addArcWithCenter:CGPointMake((3*w),w) radius:radius startAngle:M_PI endAngle:0 clockwise:YES];
    
    // endPoint 曲线的终点
    // controlPoint 控制点
    // 这个方法一定要先有个起点
    [path addQuadCurveToPoint:CGPointMake(2*w, 4*w) controlPoint:CGPointMake( 4*w, 4 * w *0.6)];
    // 上一个path的终点是这个path的起点
    [path addQuadCurveToPoint:CGPointMake(0, w) controlPoint:CGPointMake(0, 4*w*0.6)];
    
    // miaocontrolPoint
    [[UIColor greenColor] setStroke];
    
    [path stroke];
    [path addClip];
    
    [path setLineCapStyle:kCGLineCapRound];
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    view.layer.mask = layer;
    
    

}

@end
