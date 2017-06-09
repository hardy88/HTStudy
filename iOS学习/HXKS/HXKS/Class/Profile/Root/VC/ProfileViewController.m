//
//  ProfileViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

// vc
#import "ProfileViewController.h"
#import "HTUserCenterViewController.h"
#import "HTOrderViewController.h"
#import "HTOnlineAnswerViewController.h"
#import "HTSystemSettingViewController.h"
#import "AppDelegate.h"

//  view
#import "HTProfileCell.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tbView;
    NSArray *dataArr;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupBaseView
{
    dataArr = @[@"\ue615 我的订单",@"\ue60f 个人中心",@"\ue65a 在线客服",@"\ue616 系统设置"];
    
    // 创建界面
    self.view.backgroundColor = [UIColor whiteColor];
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.tableHeaderView = [self returnHeaderView];
    tbView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tbView];
    
}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
    // 发生请求
}
- (UIView*)returnHeaderView
{
    
    UIView *bdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    // 右侧少100
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-100, 200)];
    view.image = [UIImage imageNamed:@"htHeader.png"];
    [bdView addSubview:view];
    
    
    CGFloat W = CGRectGetWidth(view.frame) ;
    CGFloat X = ( W-80)/2;
    CGFloat Y = (CGRectGetHeight(view.frame) -80) / 2;
    
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(X, Y, 80, 80)];
    headerImage.layer.masksToBounds = YES;
    headerImage.layer.cornerRadius = 40;
    headerImage.backgroundColor = [UIColor whiteColor];
    headerImage.image = [UIImage imageNamed:@"htcat.JPG"];
    [bdView addSubview:headerImage];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerImage.frame)+20, W, 30)];
    accountLabel.text = @"账号：1552222333";
    accountLabel.font = [UIFont systemFontOfSize:18];
    accountLabel.textColor = [UIColor whiteColor];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    [bdView addSubview:accountLabel];
    
    return bdView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id_forCell = @"HTDrawerLeft_cell_id";
    HTProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:id_forCell];
    if (!cell)
    {
        cell = [[HTProfileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id_forCell];
    }
    cell.textStr =dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    switch (indexPath.row)
    {
        case 0:
        {
            HTOrderViewController *vc = [[HTOrderViewController alloc] init];
            [tempAppDelegate.mainVC toNext:vc];
        }
            break;
            
        case 1:
        {
            HTUserCenterViewController *vc = [[HTUserCenterViewController alloc] init];
            [tempAppDelegate.mainVC toNext:vc];
        }
            break;
        case 2:
        {
            HTOnlineAnswerViewController *vc = [[HTOnlineAnswerViewController alloc] init];
            [tempAppDelegate.mainVC toNext:vc];
        }
            break;
        case 3:
        {
            HTSystemSettingViewController *vc = [[HTSystemSettingViewController alloc] init];
            [tempAppDelegate.mainVC toNext:vc];
        }
            break;
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(LeftVcClick)])
    {
        [self.delegate LeftVcClick];
    }
}

@end
