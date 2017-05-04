//
//  HTVideoViewController.m
//  HTHXBB
//
//  Created by hardy on 17/1/22.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTVideoViewController.h"

@interface HTVideoViewController ()

@end

@implementation HTVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    //  [self addLeftNavText:@"返回" action:@selector(toBakc)];
    // [self hideLeftItem];
    [self addRightNavText:@"完成" action:@selector(toDone)];
}

- (void)toBakc
{
    NSLog(@"");
    [self.curNav popViewControllerAnimated:YES];
}

- (void)toDone
{
    NSLog(@"完成");
    [self.curNav popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
