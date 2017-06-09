//
//  LeftVc.m
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

// vc
#import "HTDrawerLeft.h"
#import "HTUserCenterViewController.h"
#import "HTOrderViewController.h"
#import "HTOnlineAnswerViewController.h"
#import "HTSystemSettingViewController.h"
#import "AppDelegate.h"


@interface HTDrawerLeft ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tbView;
    NSArray *dataArr;
}

@end

@implementation HTDrawerLeft

- (void)viewDidLoad {
    [super viewDidLoad];
  
}
- (void)setupBaseView
{
    dataArr = @[@"我的订单",@"个人中心",@"在线客服",@"系统设置"];
    
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(LeftVcClick)])
    {
        [self.delegate LeftVcClick];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id_forCell = @"HTDrawerLeft_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id_forCell];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id_forCell];
    }
    cell.detailTextLabel.text =dataArr[indexPath.row];
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

@end
