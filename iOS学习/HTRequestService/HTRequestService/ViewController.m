//
//  ViewController.m
//  HTRequestService
//
//  Created by hardy on 2017/9/28.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"
#import "HTRequestService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
////    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
////    [webView loadRequest:request];
//    [self.view addSubview:webView];
    
    __weak typeof(self) weakSelf = self;
    [HTRequestService requestURL:@"https://www.baidu.com" httpMethod:@"GET" params:nil complection:^(id response) {
        NSLog(@"");
    } error:^(NSError *err, id errMsg) {
        NSLog(@"");
    }];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
