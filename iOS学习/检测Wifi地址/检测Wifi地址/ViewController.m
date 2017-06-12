//
//  ViewController.m
//  检测Wifi地址
//
//  Created by hardy on 2017/6/12.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "ViewController.h"
#import "HTIPHelper.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [HTIPHelper getCurrentLocalIP];
    
    NSLog(@"WIFI地址为%@", [HTIPHelper getCurreWiFiSsid]);
}



@end
