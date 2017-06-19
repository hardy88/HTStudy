//
//  ViewController.m
//  Quartz2D画图
//
//  Created by hardy on 2017/6/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"

#import "HTLineView.h"
#import "HTRectView.h"
#import "HTArcView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imgView.image = [UIImage imageNamed:@"liuYan.jpeg"];
    imgView.backgroundColor = [UIColor blueColor];
#if 0
//  CALayer
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = 50;
 
#endif
    UIImage *image =  [UIImage imageNamed:@"liuYan.jpeg"];
    NSLog(@"图片大小%f %f", image.size.width,image.size.height );
    
    // 我们重新绘图，将图片在100x100大小的画布上绘制
    CGSize size = CGSizeMake(100, 100);
    // 设置画图大小
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [image drawInRect:CGRectMake(0,0,100, 100)];
//    [image drawInRect:CGRectMake(25,25,50, 50)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"修改后大小%f %f", scaledImage.size.width,scaledImage.size.height );
    imgView.image = scaledImage;
    UIGraphicsEndImageContext();
    
    [self.view addSubview:imgView];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HTArcView *view = [[HTArcView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
}

@end
