//
//  HTOpenFailViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

// vc
#import "HTOpenFailViewController.h"

// view
#import "HTSeparator.h"
#import "HTOpenDoneCell.h"
#import "HTClockOpenFailCell.h"

// model
#import "HTOpenClockOrderModel.h"

@interface HTOpenFailViewController ()<UITableViewDataSource,UITableViewDelegate,HTClockOpenFailCellDelegate>
{
    UITableView *tbView;
}

@end

@implementation HTOpenFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupBaseView
{
    
    self.navTitle = @"开锁失败";
    [self addRightNavText:@"提交" action:@selector(openFailToSubmit)];
    // 创建界面
    self.view.backgroundColor = [UIColor lightGrayColor];
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    tbView.tableHeaderView=[self returnHeaderView];
    tbView.tableFooterView = [[UIView alloc] init];
    
    UITapGestureRecognizer *tapGes =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditView)];
    [tbView addGestureRecognizer:tapGes];
    
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
    UIView *sectionFootView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    sectionFootView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    return sectionFootView;
}
- (void)openFailToSubmit
{
    // 提交
    [self.view endEditing:YES];
}

- (void)endEditView
{
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [HTOpenDoneCell returnCellHeight];
    }
    return [HTClockOpenFailCell returnCellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==1)
    {
        return CGFLOAT_MIN;
    }
    return 15;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *sectionFootView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    sectionFootView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    return sectionFootView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.section)
    {
        case 0:
        {
            HTOpenDoneCell  *doneCell = [tableView dequeueReusableCellWithIdentifier:[HTOpenDoneCell returnCellID]];
            if (!doneCell)
            {
                doneCell = [[HTOpenDoneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[HTOpenDoneCell returnCellID]];
            }
            HTOpenClockOrderModel *model = [[HTOpenClockOrderModel alloc] init];
            model.applyer = @"张先生";
            model.telStr = @"15236987415";
            model.addStr = @"安顺家园5栋505室";
            model.hsaLock = YES;
            model.lockType = @(1);
            model.timeStr = @"2017-05-20 14:24:55";
            [doneCell configCellWithModel:model];
            cell = doneCell;
        }
            break;
        case 1:
        {
            HTClockOpenFailCell *failCell =  [tableView dequeueReusableCellWithIdentifier:[HTClockOpenFailCell returnCellID]];
            if (!failCell)
            {
               failCell =  [[HTClockOpenFailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[HTClockOpenFailCell returnCellID]];
            }
            failCell.delegate = self;
            cell = failCell;
        }
            break;
    }
    return cell;
}

#pragma mark -- HTClockOpenFailCellDelegate
- (void)htClockOpenFailCell:(HTClockOpenFailCell *)cell editText:(NSString *)text
{
    NSLog(@"输入信息是:%@",text);
}

@end
