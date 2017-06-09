//
//  DropDownView.h
//  下拉选项框
//
//  Created by Hardy on 16-1-3.
//  Copyright (c) 2015年 Huawei. All rights reserved.
//

#import "HTDropDownView.h"
#import "HTDropDownCell.h"

static CGFloat KCELLHEIGHT = 50;

@interface HTDropDownView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tbView;
    // tbView的数据源数组
    NSArray *strArr;
    // tbView的宽、高
    CGFloat _width;
    CGFloat _height;
}
@end

@implementation HTDropDownView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        _width = frame.size.width;
        _height = frame.size.height;
        
        self.backgroundColor = [UIColor clearColor];
        tbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 140, 110) style:UITableViewStylePlain];
        tbView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tbView.delegate=self;
        tbView.dataSource=self;
        tbView.scrollEnabled = NO;

        [self addSubview:tbView];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
        
    }
    return self;
}
-(void)setTextArr:(NSArray *)textArr
{
    self.hidden = NO;
    if (textArr == nil || textArr.count == 0)
    {
        [self destoryDropDownView];
    }
    else
    {
        strArr = [[NSArray alloc]initWithArray:textArr];
        [tbView reloadData];
    }
}
-(void)destoryDropDownView
{
    self.hidden = YES;
    [self removeFromSuperview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return strArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid =@"cell";
    HTDropDownCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell =[[HTDropDownCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.textTitle =strArr[indexPath.row];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KCELLHEIGHT;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(DropDownViewView:selectedItem:)])
    {
        [self.delegate DropDownViewView:self selectedItem:indexPath.row];
    }
}
@end
