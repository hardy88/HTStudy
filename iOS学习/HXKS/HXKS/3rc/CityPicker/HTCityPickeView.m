//
//  ASCityPickeView.m
//  hxxdj
//
//  Created by aisino on 16/3/25.
//  Copyright © 2016年 aisino. All rights reserved.

#define HTCityPickerToolBarHeight 40

#import "HTCityPickeView.h"

typedef void(^myCall)(NSString *shen, NSString *shenCode, NSString *city, NSString *cityCode, NSString *qu, NSString *quCode);

@interface HTCityPickeView()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger row1;
    NSInteger row2;
    NSInteger row3;
    myCall call;
}

@property(nonatomic,strong)UIPickerView *cityPicker;

@property(nonatomic,strong)NSArray *plistArr;

@property(nonatomic,strong)UIToolbar *toolBar;

@end

@implementation HTCityPickeView


- (UIToolbar*)toolBar
{
    if (!_toolBar)
    {
        _toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, HTCityPickerToolBarHeight)];
        UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
        
        UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
        _toolBar.items=@[lefttem,centerSpace,right];
    }
    return _toolBar;
}

- (UIPickerView*)cityPicker
{
    if (!_cityPicker)
    {
        _cityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height -40)];
        _cityPicker.backgroundColor = [UIColor lightGrayColor];
        _cityPicker.delegate = self;
        _cityPicker.dataSource = self;
    }
    return _cityPicker;
}
- (NSArray*)plistArr
{
    if (!_plistArr)
    {
        NSString *path= [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        _plistArr =[[NSArray alloc] initWithContentsOfFile:path];
    }
    return _plistArr;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.toolBar];
        [self addSubview:self.cityPicker];
    }
    return self;
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger pickerRows = 0;
    switch (component)
    {
        case 0:
            pickerRows = [self.plistArr count];
            break;
        case 1:
            pickerRows = [[[self.plistArr objectAtIndex:row1] objectForKey:@"sub"] count];
            break;
        case 2:
            pickerRows = [[[[[self.plistArr objectAtIndex:row1] objectForKey:@"sub"] objectAtIndex:row2] objectForKey:@"sub"] count];
            break;
        default:
            break;
    }
    return pickerRows;
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str;
    switch (component)
    {
        case 0:
           
            str = [[self.plistArr objectAtIndex:row] objectForKey:@"province"];
     
            break;
        case 1:
            str = [[[[self.plistArr objectAtIndex:row1] objectForKey:@"sub"] objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            str = [[[[[[self.plistArr objectAtIndex:row1] objectForKey:@"sub"] objectAtIndex:row2] objectForKey:@"sub"] objectAtIndex:row] objectForKey:@"district"];
            break;
        default:
            break;
    }
    return str;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:// 省
            row1 = row;
            row2 = 0;
            row3 = 0;
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 1://市
            row2 = row;
            row3 = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        case 2://区
            row3 = row;
            break;
        default:
            break;
    }
}
- (void)remove
{
    [self removeFromSuperview];
}

- (void)show:(void (^)(NSString *sheng, NSString *shenCode, NSString *city, NSString *cityCode, NSString *qu, NSString *quCode))callBack
{
    call = callBack;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)doneClick
{
    NSDictionary *item = [self.plistArr objectAtIndex:row1];
    // 省
    NSString *province = [item valueForKey:@"province"];
    NSString *shengCode = [item valueForKey:@"zipcode"];
    // 市
    NSArray *sub = item[@"sub"];
    NSDictionary *dic = [sub objectAtIndex:row2];
    NSString *shi = dic[@"city"];
    NSString *shiCode = dic[@"zipcode"];
    // 区
    NSArray *quArr = dic[@"sub"];
    NSDictionary *quDic = quArr[row3];
    NSString *qu = quDic[@"district"];
    NSString *quCode = quDic[@"zipcode"];

    call(province,shengCode,shi,shiCode,qu,quCode);
    
    [self removeFromSuperview];
}



@end
