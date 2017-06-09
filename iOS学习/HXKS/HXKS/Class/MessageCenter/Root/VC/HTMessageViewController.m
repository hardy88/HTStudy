//
//  HTMessageViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/19.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "HTMessageViewController.h"

// view
#import "HTMessageCell.h"
#import "HTMessageHandleCell.h"
#import "HTMessageDetailViewControoler.h"

// model
#import "HTMessageSuccessModel.h"
#import "HTMessageHandleModel.h"

@interface HTMessageViewController ()<UITableViewDelegate,UITableViewDataSource,HTMessageHandleCellDelegate>
{
    UITableView *tbView;
}

@end

@implementation HTMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupBaseView
{
    self.navTitle = @"消息中心";
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor =[UIColor colorWithHexString:@"#ECEBF3"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==  0)
    {
        return [HTMessageHandleCell returnCellHeight];
    }
    return [HTMessageCell returnCellHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id_forCell = @"id_forCell";
    
    UITableViewCell *cell;
    
    switch (indexPath.row)
    {
        case 0:
        {
            HTMessageHandleCell *handlecell = [tableView dequeueReusableCellWithIdentifier:id_forCell];
            if (!handlecell)
            {
                handlecell = [[HTMessageHandleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id_forCell];
            }
            handlecell.delegate = self;
            HTMessageHandleModel *model = [[HTMessageHandleModel alloc] init];
            model.messageTime = @"05月01日 14:24";
            model.bzStr = @"防盗门指纹锁  有反锁";
            model.addStr = @"顺天花苑12栋1505室";
            handlecell.model = model;
            cell = handlecell;
            
        }
            break;
            
        case 1:
        {
            HTMessageCell *infocell = [tableView dequeueReusableCellWithIdentifier:@"cell_id_for"];
            if (!infocell)
            {
                infocell = [[HTMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id_for"];
            }
            HTMessageSuccessModel *model = [[HTMessageSuccessModel alloc] init];
            model.messageTime = @"16:20";
            model.contect = @"张先生";
            model.addressStr = @"安顺家园5栋505室";
            model.telStr = @"15698742361";
            infocell.model = model;
            cell = infocell;
        }
        break;
    }
    return cell;
}




#pragma mark -- HTMessageHandleCell
- (void)HTMessageHandleCellCheckDetailInfo
{
    HTMessageDetailViewControoler *vc = [[HTMessageDetailViewControoler alloc] init];
    [self.curNav toNext:vc];
}

@end
