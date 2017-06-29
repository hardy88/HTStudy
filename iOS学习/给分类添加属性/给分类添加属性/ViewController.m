//
//  ViewController.m
//  给分类添加属性
//
//  Created by hardy on 2017/6/29.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"

#import "HTFather.h"
#import "HTFather+Extention.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HTFather *father = [[HTFather alloc] init];
    father.name = @"Father";
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
