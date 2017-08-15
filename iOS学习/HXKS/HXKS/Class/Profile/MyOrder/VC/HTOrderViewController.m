//
//  HTOrderViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


// VC
#import "HTOrderViewController.h"

// View
#import "HXKSOrderListCell.h"

// Request
#import "HXKSOrderListRequest.h"

@interface HTOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     UITableView *tbView;
}
@end

@implementation HTOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupBaseView
{
    // 创建界面
    self.navTitle = @"我的订单";
    [self addRightNavText:@"清除" action:@selector(clearOrderList)];
    // 创建界面
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    tbView.tableFooterView = [[UIView alloc] init];
//    tbView.tableHeaderView =[self returnHeaderView];
    [self.view addSubview:tbView];

}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
//    // 发生请求
//    [HTHubProgress showWaitMessage:@"" onView:self.view];
//    [HXKSOrderListRequest hxksOrderListRequestSuccess:^(NSURLSessionDataTask *task, id response) {
//        
//        [HTHubProgress hideHub:self.view];
////        [tbView reloadData];
//        
//    } failuer:^(NSURLSessionDataTask *task, id errMsg) {
//        [HTHubProgress hideHub:self.view];
//        [HTHubProgress showHintMessage:errMsg onView:self.view];
//    }];
}
- (void)clearOrderList
{
    
}

#pragma mark --- UITableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [HXKSOrderListCell cellHight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXKSOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HXKSOrderListCell cellIdentify]];
    if (!cell)
    {
        cell = [[HXKSOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HXKSOrderListCell cellIdentify]];
    }
    return cell;
}
@end
