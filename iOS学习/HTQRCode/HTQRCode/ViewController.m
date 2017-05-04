//
//  ViewController.m
//  HTQRCode
//
//  Created by hardy on 2017/5/3.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import "HTQRCodeCreater.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    HTQRCodeCreater *qrCreater = [[HTQRCodeCreater alloc] init];
    UIImage *QRImage = [qrCreater createQRCodeWithUrlString:@"http://www.jianshu.com/p/4a9e34631ca3" qRCodeSize:100 centerLogo:[UIImage imageNamed:@"IMG_1314.png"] logoSize:30];
    
    UIImageView *QRView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 180, 180)];
    QRView.image = QRImage;
    
    [self.view addSubview:QRView];
}


@end
