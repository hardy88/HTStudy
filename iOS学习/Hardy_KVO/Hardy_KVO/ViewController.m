//
//  ViewController.m
//  Hardy_KVO
//
//  Created by hardy on 2017/12/18.
//  Copyright © 2017年 Hardy Hu. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+HT_KVO.h"
#import "Son.h"

@interface ViewController ()

@property (nonatomic,strong) Son *son;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.son = [[Son alloc] init];
    [self.son ht_addObserver:self forKeyPath:@"Name" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"%@",[self.son class]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"监听到了KVO--%@",keyPath);
    NSLog(@"新值是多少：%@",change[@"new"]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    i++;
     NSLog(@"%@",[self.son class]);
    self.son.Name = [NSString stringWithFormat:@"%d",i];
     NSLog(@"%@",[self.son class]);
}

@end
