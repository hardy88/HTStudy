//
//  ViewController.m
//  动态添加方法
//
//  Created by hardy on 2017/6/29.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import "HTModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HTModel *model = [[HTModel alloc] init];
    [model performSelector:@selector(printObj)];
    
}


@end
