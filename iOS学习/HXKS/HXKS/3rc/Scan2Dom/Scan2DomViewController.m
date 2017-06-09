//
//  Scan2DomViewController.m
//  hxszy
//
//  Created by hardy on 16/6/16.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//




#import "Scan2DomViewController.h"
#import "Scan2DomView.h"

@interface Scan2DomViewController ()<Scan2DomDelegate>

@end

@implementation Scan2DomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Scan2DomView *view = [[Scan2DomView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT)];
//    view.delegate = self;
//    [self.view addSubview:view];
}
-(void)scanView:(Scan2DomView*)scanView codeInfo:(NSString*)codeInfo
{
    if ([self.delegate respondsToSelector: @selector(scanCodeController:codeInfo:)])
    {
        [self.delegate scanCodeController: self codeInfo: codeInfo];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
