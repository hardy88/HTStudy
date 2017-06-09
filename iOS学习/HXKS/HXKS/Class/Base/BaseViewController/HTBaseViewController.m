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
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
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
- (void)addLeftTTFText:(NSString*)leftNavTitle
                action:(SEL)action
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIButton *leftItemBut = [UIButton buttonWithType:UIButtonTypeCustom];
        leftItemBut.frame = CGRectMake(0, 0, 30, 30);
        leftItemBut.titleLabel.font = [UIFont fontWithName:@"iconfont" size:22];
        [leftItemBut setTitle:leftNavTitle forState:UIControlStateNormal];
        [leftItemBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [leftItemBut addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftItemBut];
        self.navigationItem.leftBarButtonItem = item;
    }

}

- (void)addLeftNavImage:(NSString*)leftImage
                 action:(SEL)action
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:leftImage] style:UIBarButtonItemStylePlain target:self action:action];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)addRightNavText:(NSString*)rightNavTitle
              action:(SEL)action
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, 0, 50, 20);
        [but setTitle:rightNavTitle forState:UIControlStateNormal];
        but.userInteractionEnabled = YES;
        [but setTitleColor:[UIColor colorWithHexString:@"#D1123A"] forState:UIControlStateNormal];
        [but addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:but];
        self.navigationItem.rightBarButtonItem = item;
    }
}
- (void)addRightTTFText:(NSString*)rightNavTitle
                 action:(SEL)action;
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIButton *leftItemBut = [UIButton buttonWithType:UIButtonTypeCustom];
        leftItemBut.frame = CGRectMake(0, 0, 30, 30);
        leftItemBut.titleLabel.font = [UIFont fontWithName:@"iconfont" size:22];
        [leftItemBut setTitle:rightNavTitle forState:UIControlStateNormal];
        [leftItemBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [leftItemBut addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftItemBut];
        self.navigationItem.rightBarButtonItem = item;
    }
}
- (void)addRightNavImage:(NSString*)rightImage
                  action:(SEL)action
{
    if (self.navigationController
        && [self.navigationController isKindOfClass:[HTNavigationController class]])
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:rightImage] style:UIBarButtonItemStylePlain target:self action:action];
        self.navigationItem.leftBarButtonItem = item;
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

- (void)hideNavBar:(BOOL)isHide
{
   self.navigationController.navigationBarHidden = isHide;
}

- (void)toNext
{
}

@end
