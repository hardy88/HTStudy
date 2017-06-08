//
//  RightVc.m
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import "RightVc.h"
#import "HTNextViewController.h"
#import "AppDelegate.h"

@interface RightVc ()

@end

@implementation RightVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.title = @"Home";
    
    UIButton *clickBut = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBut.frame = CGRectMake(10, 200, 100, 30);
    [clickBut setTitle:@"按钮" forState:UIControlStateNormal];
    [clickBut setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [clickBut addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBut];
    
    UIButton *nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBut.frame = CGRectMake(10, 300, 100, 30);
    [nextBut setTitle:@"下一页" forState:UIControlStateNormal];
    [nextBut setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [nextBut addTarget:self action:@selector(nextBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBut];
    
}

-(void)setMessage:(NSString *)message
{
    NSLog(@"打印刷新 ----%@",message);
}

- (void)clickBut:(UIButton*)but
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainVC openSide];

}
- (void)nextBut:(UIButton*)next
{
    HTNextViewController *vc = [[HTNextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
