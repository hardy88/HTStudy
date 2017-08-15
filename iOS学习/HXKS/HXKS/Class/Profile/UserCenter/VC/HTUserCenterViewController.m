//
//  HTUserCenterViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTUserCenterViewController.h"

// view
#import "HTUsercenterView.h"
#import "HTAddressEditView.h"

@interface HTUserCenterViewController ()
{
    UIScrollView *scView;
}
@end

@implementation HTUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupBaseView
{
    // 创建界面
    self.navTitle = @"个人中心";
    [self addRightNavText:@"编辑" action:@selector(editItemClick)];
    
    scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT)];
    scView.showsVerticalScrollIndicator = NO;
    scView.showsHorizontalScrollIndicator = NO;
    scView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    [self.view addSubview:scView];
    
    
    UIView *headerBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, 200)];
    headerBaseView.backgroundColor = [UIColor colorWithHexString:@"#7FD0EE"];
    [scView addSubview:headerBaseView];
    
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake((SC_WIDTH-100)/2, 40, 100, 100)];
    headerImage.layer.masksToBounds = YES;
    headerImage.layer.cornerRadius = 50;
    headerImage.backgroundColor = [UIColor whiteColor];
    headerImage.image = [UIImage imageNamed:@"htcat.JPG"];
    [headerBaseView addSubview:headerImage];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerImage.frame)+10, SC_WIDTH, 30)];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.text = @"账号：";
    accountLabel.font = [UIFont systemFontOfSize:18];
    accountLabel.textColor = [UIColor whiteColor];
    [headerBaseView addSubview:accountLabel];
    HXKSManager *manager = [HXKSManager manager];
    if (manager.loginSuccess)
    {
        accountLabel.text = [NSString stringWithFormat:@"账号：%@",manager.userInfo.phonenum];
    }
    
    
    
    HTUsercenterView *beianView = [[HTUsercenterView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(headerBaseView.frame)+20, SC_WIDTH - 20, 50) andTitle:@"\ue60f  公安备案"];
    [scView addSubview:beianView];
    
    HTUsercenterView *rezhenView = [[HTUsercenterView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(beianView.frame)+20, SC_WIDTH - 20, 50) andTitle:@"\ue615  实名认证"];
    [scView addSubview:rezhenView];
    
    HTAddressEditView *addressEdit = [[HTAddressEditView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(rezhenView.frame)+20, SC_WIDTH - 20, 80) andTitle:@"地址：湖北省武汉市武昌区中北路128号凤天苑小区2栋5单元1101室"];
   [scView addSubview:addressEdit];
    
}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
    // 发生请求
}

- (void)editItemClick
{
    
}

@end
