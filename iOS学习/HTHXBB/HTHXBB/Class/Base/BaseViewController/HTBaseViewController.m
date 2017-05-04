//
//  HTBaseViewController.m
//  HTHXBB
//
//  Created by hardy on 17/1/20.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTBaseViewController.h"

@interface HTBaseViewController ()

@end

@implementation HTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseView];
    [self setBaseData];
    [self setupRequest];
}
- (void)setupBaseView
{
    // 创建界面
}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
    // 发生请求
}

- (HTNavigationController*)curNav
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        return  (HTNavigationController*)self.navigationController;
    }
    return nil;
}

- (void)setNavTitle:(NSString *)navTitle
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        _navTitle = navTitle;
         self.navigationItem.title = navTitle;
    }
}

- (void)setRightNavTitle:(NSString *)rightNavTitle
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:rightNavTitle style:UIBarButtonItemStylePlain target:self action:@selector(toNext)];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)addLeftNavText:(NSString*)leftNavTitle
             action:(SEL)action
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:leftNavTitle style:UIBarButtonItemStylePlain target:self action:action];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)addRightNavText:(NSString*)rightNavTitle
              action:(SEL)action
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:rightNavTitle style:UIBarButtonItemStylePlain target:self action:action];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)toBack
{
    [self.curNav toBakc];
}

- (void)hideLeftItem
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void)toNext
{
}

@end
