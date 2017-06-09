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


// other
#import "AppDelegate.h"


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
}
@end

@implementation HTHomeViewCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [bdMapView viewWillAppear];
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
    [self addLeftTTFText:@"\ue631" action:@selector(sideClick)];
    [self addRightTTFText:@"\ue61e" action:@selector(toMessage)];

    
    // 添加百度地图和定位
    [self addBaiduMap];
    // 订单位置导航
    [self addMapNavigation];
    // 开锁进程处理
    [self addClockProcess];
    
}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
    // 发生请求
}

- (void)addBaiduMap
{
    bdMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64,SC_WIDTH, SC_HEIGHT)];
    bdMapView.zoomLevel = 21;
    bdMapView.mapType = BMKMapTypeStandard;
    bdMapView.userTrackingMode = BMKUserTrackingModeHeading;
    [self.view addSubview:bdMapView];
    
    locService = [[BMKLocationService alloc] init];
    locService.desiredAccuracy = 100.0f;
    [locService startUserLocationService];
}
- (void)addMapNavigation
{
    UIView *navMap = [[UIView alloc] initWithFrame:CGRectMake(12, 80, SC_WIDTH-24, 50)];
    navMap.backgroundColor = [UIColor whiteColor];
    navMap.layer.borderColor = [UIColor colorWithHexString:@"#C2C1C1"].CGColor;
    navMap.layer.borderWidth=0.5;
    [self.view addSubview:navMap];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(CGRectGetWidth(navMap.frame) - 50, 5, 50, 40);
    but.titleLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    [but setTitle:@"\ue617" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(stratNav:) forControlEvents:UIControlEventTouchUpInside];
    [navMap addSubview:but];
}
- (void)addClockProcess
{
    UIButton *doneClik = [UIButton buttonWithType:UIButtonTypeCustom];
    doneClik.frame = CGRectMake(10, SC_HEIGHT -150, 100, 30);
    [doneClik setTitle:@"完成开锁" forState:UIControlStateNormal];
    [doneClik setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [doneClik addTarget:self action:@selector(doneOpenClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneClik];
    
    UIButton *failClik = [UIButton buttonWithType:UIButtonTypeCustom];
    failClik.frame = CGRectMake(SC_WIDTH-150, SC_HEIGHT -150, 100, 30);
    [failClik setTitle:@"开锁失败" forState:UIControlStateNormal];
    [failClik setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [failClik addTarget:self action:@selector(failOpenClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:failClik];
}

- (void)stratNav:(UIButton*)but
{
    HTDropDownView *view = [[HTDropDownView alloc] initWithFrame:CGRectMake(SC_WIDTH-150, 135, 140, 130)];
    view.textArr =@[@"\ue799  位置导航",@"\ue632  取消订单"];
    view.delegate = self;
    [self.view addSubview:view];
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
    // 是否显示定位位置
    bdMapView.showsUserLocation = YES;
    // 设置地图中心点
    bdMapView.centerCoordinate = userLocation.location.coordinate;
    CLLocationCoordinate2D loc = [userLocation.location coordinate];
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(loc,BMKCoordinateSpanMake(0.02f,0.02f));
    BMKCoordinateRegion adjustedRegion = [bdMapView regionThatFits:viewRegion];
    [bdMapView setRegion:adjustedRegion animated:YES];

    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title = @"我当前的位置";
    [bdMapView removeAnnotations:bdMapView.annotations];
    [bdMapView addAnnotation:annotation];
}
@end
