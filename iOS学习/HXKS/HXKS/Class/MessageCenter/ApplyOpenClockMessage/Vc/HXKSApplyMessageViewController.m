//
//  HXKSApplyMessageViewController.m
//  HXKS
//
//  Created by hardy on 2017/8/11.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HXKSApplyMessageViewController.h"

#import "HXKSApplyOpenClockMessageCell.h"

@interface HXKSApplyMessageViewController ()<UITableViewDelegate,UITableViewDataSource,HXKSApplyOpenClockMessageCellDelegate>
{
    UITableView *tbView;
}
@end

@implementation HXKSApplyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupBaseView
{
    // 创建界面
    self.navTitle = @"锁匠APP";
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
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


#pragma mark --- UITableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HXKSApplyOpenClockMessageCell returnCellHight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXKSApplyOpenClockMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[HXKSApplyOpenClockMessageCell returnCellId]];
    if (!cell)
    {
        cell = [[HXKSApplyOpenClockMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[HXKSApplyOpenClockMessageCell returnCellId]];
    }
    cell.delegate = self;
    cell.index =  indexPath.row;
    return cell;
}


#pragma mark --- HXKSApplyOpenClockMessageCellDelegate
// 清除
- (void)HXKSApplyOpenClockMessageCellClear:(NSInteger)index
{
    DLog(@"清除%ld",(long)index);
}
// 接受申请
- (void)HXKSApplyOpenClockMessageCellAcceptApply:(NSInteger)index
{
    DLog(@"接受申请%ld",(long)index);
}
@end
