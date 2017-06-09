//
//  AppDelegate.m
//  HXKS
//
//  Created by hardy on 2017/5/9.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

#import "AppDelegate.h"
// vc
#import "ProfileViewController.h"
#import "HTHomeViewCotroller.h"
#import "LeftSlideViewController.h"
#import "HXLoginViewController.h"


// baiduMap
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件


@interface AppDelegate ()<CLLocationManagerDelegate>
{
    BMKMapManager *_mapManager;
     CLLocationManager * locationManager; // 使用系统原生定位
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    ProfileViewController *side = [[ProfileViewController alloc] init];
    HTHomeViewCotroller *content = [[HTHomeViewCotroller alloc] init];
    self.mainVC = [[HTNavigationController alloc] initWithRootViewController:content];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:side andMainView:self.mainVC];
    [self.LeftSlideVC setPanEnabled:NO];
    
    
    HXLoginViewController *vc = [[HXLoginViewController alloc] init];
    HTNavigationController *nvc = [[HTNavigationController alloc] initWithRootViewController:vc];
//    self.window.rootViewController = nvc ;
    self.window.rootViewController = self.LeftSlideVC ;
    [self.window makeKeyAndVisible];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"A6OULC1pPv9SdbS2fWMo1FwEHd1G814K"  generalDelegate:nil];
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
    [self startLocation];
    return YES;
}

// 开始定位
- (void)startLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; // 设置进度
    locationManager.distanceFilter  = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];  // 开始定位
    [locationManager startUpdatingHeading];  // 开始更新方向
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

// 定位获取到数据后
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    self.curLatitude =  [NSString stringWithFormat:@"%f",coor.latitude];
    self.curLongtitude = [NSString stringWithFormat:@"%f",coor.longitude];
    [locationManager stopUpdatingHeading];
    [locationManager stopUpdatingLocation];
}


@end
