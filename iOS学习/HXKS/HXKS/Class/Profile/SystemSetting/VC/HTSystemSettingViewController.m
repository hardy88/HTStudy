//
//  HTSystemSettingViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTSystemSettingViewController.h"

#import "HXKSLoginViewController.h"
#import "AppDelegate.h"

// view
#import "HTSystemSettingCell.h"

// Request
#import "HXKSLogoutRequest.h"

@interface HTSystemSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tbView;
    
    NSArray *textArr;
}

@end

@implementation HTSystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupBaseView
{
    // 创建界面
    self.navTitle = @"系统设置";
    
    textArr = @[@"消息推送",@"清除缓存",@"用户反馈",@"关于我们"];
    
    
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SC_WIDTH, SC_HEIGHT-20) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor colorWithHexString:@"#F0EFF5"];
    tbView.tableFooterView = [self returnFootView];
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


- (UIView*)returnFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, 100)];
    
    UIButton *logoutBut = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBut.frame = CGRectMake(12, 30, SC_WIDTH-24, 50);
    [logoutBut setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBut setTitleColor:[UIColor colorWithHexString:@"#636363"] forState:UIControlStateNormal];
    [logoutBut addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
    [logoutBut setBackgroundColor:[UIColor whiteColor]];
    [footView addSubview:logoutBut];
    
    return footView;
}

- (void)logoutClick:(UIButton*)but
{

    [HTHubProgress showWaitMessage:@"正在登出。。。" onView:self.view];
    [HXKSLogoutRequest hxksLogoutRequest:nil success:^(NSURLSessionDataTask *task, id response) {
        
        [HTHubProgress hideHub:self.view];
        HXKSLoginViewController *vc = [[HXKSLoginViewController alloc] init];
        [self.curNav toNext:vc];
        
    } failure:^(NSURLSessionDataTask *task, id err) {
        
        [HTHubProgress hideHub:self.view];
        [HTHubProgress showHintMessage:err onView:self.view];
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HTSystemSettingCell returnCellHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id_forCell = @"id_forCell";
    HTSystemSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:id_forCell];
    if (!cell)
    {
        cell = [[HTSystemSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id_forCell];
    }
    cell.textStr = textArr[indexPath.row];
    if (indexPath.row == 0)
    {
        UISwitch *messageSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [messageSwitch addTarget:self action:@selector(messageChangeModel:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = messageSwitch;
        
    }
    if (indexPath.row == 2 || indexPath.row == 3)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (void)messageChangeModel:(UISwitch*)sender
{
//    [sender setOn:NO animated:YES];
    
    NSLog(@"%d",sender.on);
}

@end
