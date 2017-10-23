//
//  ViewController.m
//  HTPlayerDemo
//
//  Created by hardy on 2017/10/23.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(100, 100, 100, 100);
    [but setTitle:@"跳转" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:but];
    
    [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)butClick:(UIButton *)sender
{
    NextViewController  *vc = [[NextViewController  alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}




@end
