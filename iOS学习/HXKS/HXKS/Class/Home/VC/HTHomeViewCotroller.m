//
//  RightVc.m
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

// vc
#import "HTHomeViewCotroller.h"
#import "HXLoginViewController.h"
#import "HTOpenDoneViewController.h"
#import "HTOpenFailViewController.h"
#import "HTMessageViewController.h"

// view
#import "HTDropDownView.h"
#import "HTCustomerOrderView.h"
#import "HTOrderAndNavigationView.h"
#import "HTClockDoneOrFailView.h"
#import "HTOrderInfoView.h"


// other
#import "AppDelegate.h"
#import "ProgressHUD.h"
#import "HTPointAnnotation.h"

// model
#import "HTCustomerInfoModel.h"


// BaiDuMap
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h> //只引入所需的单个头文件

@interface HTHomeViewCotroller ()<BMKMapViewDelegate,BMKLocationServiceDelegate,DropDownViewDelegate>
{
    BMKMapView *bdMapView; //基本地图
    
    BMKLocationService *locService; // 百度定位
    
    HTDropDownView *navAndOrderView; // 导航和取消订单
    
    BOOL isSelect; //  记录是否被选中
    
    HTCustomerOrderView *customerorderView; // 客户订单详情推送信息
    
    HTClockDoneOrFailView *doneFailView; // 完成开锁 或开锁失败
    
    BMKAnnotationView *selectAnnotationView; // 记录选中的大头针试图
    HTCustomerInfoModel *orderModel; // 记录选中大头针Annotation
    
    NSMutableArray *annotationArr; // 放地图上的大头针
    
    HTOrderInfoView *getOrder; // 已接单
    
    HTOrderAndNavigationView *navView; // 您已经成功接单，请尽快上门服务
    
    UIButton *readeyBut; // 已到达准备开锁
}
@end

@implementation HTHomeViewCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    bdMapView.delegate = self;
    locService.delegate = self;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [bdMapView viewWillDisappear];
    bdMapView.delegate = nil;
    locService.delegate = nil;
}
- (void)setupBaseView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"武昌区";
    isSelect = NO;
    annotationArr = [NSMutableArray arrayWithCapacity:0];
    [self addLeftTTFText:@"\ue631" action:@selector(sideClick)];
    [self addRightTTFText:@"\ue61e" action:@selector(toMessage)];
    // 添加百度地图和定位
    [self addBaiduMap];
}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
    // 发生请求
}
- (void)addCustomerView
{
    customerorderView = [[HTCustomerOrderView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH , SC_HEIGHT)];
    customerorderView.model = orderModel;
    [customerorderView addCloseTarget:self action:@selector(closeDDClick:) forControlEvents:UIControlEventTouchUpInside];
    [customerorderView addQDTarget:self action:@selector(qdClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customerorderView];
}
- (void)showOrderInfo
{
    // 已接单
    getOrder= [[HTOrderInfoView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH , SC_HEIGHT)];
    getOrder.model = orderModel;
    [getOrder addCloseTarget:self action:@selector(closeOrderViewClick:)];
    [self.view addSubview:getOrder];
}
- (void)addClockApplyInfo
{
    [self performSelector:@selector(addClockAnimation) withObject:nil afterDelay:3];
}
- (void)addClockAnimation
{
    [self addCustomerView];
    [UIView animateWithDuration:1.5 animations:^{
        customerorderView.frame = CGRectMake(0, 0, SC_WIDTH , SC_HEIGHT);
    }];
}

- (void)closeOrderViewClick:(UIButton*)but
{
    [getOrder removeFromSuperview];
    getOrder = nil;
}

- (void)closeDDClick:(UIButton*)but
{
    [customerorderView removeFromSuperview];
    customerorderView = nil;
    selectAnnotationView = nil;
}
- (void)qdClick:(UIButton*)but
{
    for (HTPointAnnotation *annotation in annotationArr)
    {
        if (annotation != selectAnnotationView.annotation)
        {
            [bdMapView removeAnnotation:annotation];
        }
        else
        {
            selectAnnotationView.image = [UIImage imageNamed:@"selectImage.png"];
        }
    }
    
    
    [customerorderView removeFromSuperview];
    customerorderView = nil;
    [ProgressHUD showInfo:@"抢单成功" onView:self.view];
    [ProgressHUD hideAfterSuccessOnView:self.view];
    // 订单位置导航
    // 已经成功接单，请尽快上门服务
    [self addMapNavigation];
    
    readeyBut= [UIButton buttonWithType:UIButtonTypeCustom];
    readeyBut.frame = CGRectMake((SC_WIDTH-200)/2, SC_HEIGHT - 100, 200, 50);
    readeyBut.backgroundColor = [UIColor colorWithHexString:@"#D00030"];
    [readeyBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [readeyBut setTitle:@"已到达准备开锁" forState:UIControlStateNormal];
    readeyBut.layer.masksToBounds = YES;
    readeyBut.layer.cornerRadius = 5;
    [readeyBut addTarget:self action:@selector(readyToOpenClock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readeyBut];
    
}
- (void)readyToOpenClock:(UIButton*)but
{
    [but removeFromSuperview];
    but = nil;
    [self addClockProcess];
}
- (void)addBaiduMap
{
    bdMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0,SC_WIDTH, SC_HEIGHT)];
    bdMapView.zoomLevel = 3;
    bdMapView.mapType = BMKMapTypeStandard;
    [bdMapView viewWillAppear];
    bdMapView.userTrackingMode = BMKUserTrackingModeNone;
    // 是否显示定位位置
    bdMapView.showsUserLocation = YES;
    [self.view addSubview:bdMapView];
    
    locService = [[BMKLocationService alloc] init];
    locService.desiredAccuracy = 100.0f;
    [locService startUserLocationService];
}
- (void)addMapNavigation
{
    navView = [[HTOrderAndNavigationView alloc] initWithFrame:CGRectMake(12, 80, SC_WIDTH-24, 50)];
    [navView addTarget:self action:@selector(stratNav:)];
    [self.view addSubview:navView];
}
- (void)addClockProcess
{
    doneFailView = [[HTClockDoneOrFailView alloc] initWithFrame:CGRectMake(0, SC_HEIGHT - 100, SC_WIDTH, 50)];
    [doneFailView addClockDoneTarget:self action:@selector(doneOpenClick:)];
    [doneFailView addClockDFailTarget:self action:@selector(failOpenClick:)];
    [self.view addSubview:doneFailView];
}

- (void)stratNav:(UIButton*)but
{
    isSelect = !isSelect;
    if (isSelect)
    {
        navAndOrderView = [[HTDropDownView alloc] initWithFrame:CGRectMake(SC_WIDTH-130, 135, 120, 130)];
        navAndOrderView.textArr =@[@"\ue799  位置导航",@"\ue632  取消订单"];
        navAndOrderView.delegate = self;
        [self.view addSubview:navAndOrderView];
    }
    else
    {
        [navAndOrderView removeFromSuperview];
        navAndOrderView.delegate = nil;
        navAndOrderView = nil;
    }
   
}

// 完成开锁
- (void)doneOpenClick:(UIButton*)sender
{
    HTOpenDoneViewController *vc = [[HTOpenDoneViewController alloc] init];
    
    [self.curNav toNext:vc];
}
// 开锁失败
- (void)failOpenClick:(UIButton*)sender
{
    HTOpenFailViewController *vc = [[HTOpenFailViewController alloc] init];
    [self.curNav toNext:vc];
}

-(void)setMessage:(NSString *)message
{
    NSLog(@"打印刷新 ----%@",message);
}

- (void)openSlide:(UIButton*)sender
{
    [UIView animateWithDuration:1.5 animations:^{
        
        self.view.frame = CGRectMake(200, 0 , [UIScreen mainScreen].bounds.size.width-200, [UIScreen mainScreen].bounds.size.height);
        
    } completion:nil];
}
- (void)toMessage
{
    HTMessageViewController *vc = [[HTMessageViewController alloc] init];
    [self.curNav toNext:vc];
}
- (void)sideClick
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

#pragma mark -- HTDropDownViewDelegate
-(void)DropDownViewView:(HTDropDownView*)moreActionView selectedItem:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    switch (index)
    {
        case 0: // 位置导航
        {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:30.596758,114.311843|name=目的地&mode=driving&coord_type=gcj02"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }
            else
            {
                [[[UIAlertView alloc]initWithTitle:@"没有安装百度地图" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil] show];
            }
        }
            
            break;
        case 1: // 取消订单
        {
            [ProgressHUD showInfo:@"取消订单成功" onView:self.view];
            [ProgressHUD hideOnView:self.view];
            
            [navView removeFromSuperview];
            navView = nil;
            
            [navAndOrderView removeFromSuperview];
            navAndOrderView.delegate = nil;
            navAndOrderView = nil;
            
            [doneFailView removeFromSuperview];
            doneFailView = nil;
            
            [readeyBut removeFromSuperview];
            readeyBut = nil;
            
            selectAnnotationView = nil;
            [bdMapView removeAnnotations:annotationArr];
            [bdMapView addAnnotations:annotationArr];
            
            orderModel = nil;
        }
            
            break;
    }
}

#pragma mark -- BMKLocationService Delegate
// 处理方向变更信息
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [bdMapView updateLocationData:userLocation];
}
// 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [bdMapView updateLocationData:userLocation];
   
    // 设置地图中心点
    bdMapView.centerCoordinate = userLocation.location.coordinate;
    CLLocationCoordinate2D loc = [userLocation.location coordinate];
//    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(loc,BMKCoordinateSpanMake(0.02f,0.02f));
//    BMKCoordinateRegion adjustedRegion = [bdMapView regionThatFits:viewRegion];
//    [bdMapView setRegion:adjustedRegion animated:YES];

    [locService stopUserLocationService];
    
//    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
//    annotation.coordinate = coor;
//    [bdMapView addAnnotation:annotation];
    
    HTPointAnnotation *annotation3 = [[HTPointAnnotation alloc] init];
    CLLocationCoordinate2D coor3;
    coor3.latitude = coor.latitude+0.001 ;
    coor3.longitude = coor.longitude- 0.001;
    annotation3.coordinate = coor3;
    annotation3.title = @"安顺家园";
    HTCustomerInfoModel *model1 = [[HTCustomerInfoModel alloc] init];
    model1.applyStr = @"张先生";
    model1.telStr = @"15549423216";
    model1.addStr = @"安顺家园5栋505室";
    model1.hasLock = YES;
    model1.lockType = @1;
    model1.desStr=@"1.4";
    model1.timeStr = @"5分钟前";
    annotation3.model = model1;
    [bdMapView addAnnotation:annotation3];
    [annotationArr addObject:annotation3];
    
    
    HTPointAnnotation *annotation2 = [[HTPointAnnotation alloc] init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = coor.latitude - 0.001;
    coor2.longitude = coor.longitude - 0.001;
    annotation2.coordinate = coor2;
    annotation2.title = @"宏祥花园";
    HTCustomerInfoModel *model2 = [[HTCustomerInfoModel alloc] init];
    model2.applyStr = @"李先生";
    model2.telStr = @"17749423216";
    model2.addStr = @"宏祥花园3栋201室";
    model2.hasLock = YES;
    model2.lockType = @1;
    model2.desStr=@"1.1";
    model2.timeStr = @"2分钟前";
    annotation2.model = model2;
    [bdMapView addAnnotation:annotation2];
    [annotationArr addObject:annotation2];
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    if (selectAnnotationView ==  view)
    {
        [self showOrderInfo];
    }
    else if([view.annotation isKindOfClass:[HTPointAnnotation class]])
    {
        selectAnnotationView = view;
        HTPointAnnotation *ann = view.annotation;
        orderModel = ann.model;
        [self addCustomerView];
    }
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        // 自定义大头针图片
        newAnnotationView.image = [UIImage imageNamed:@"unSelectImage.png"];
        return newAnnotationView;
    }
    return nil;
}
@end
