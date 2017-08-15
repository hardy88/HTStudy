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
#import "HXKSLoginViewController.h"
#import "HTNavigationController.h"


// baiduMap
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

// manager
#import "HXKSManager.h"


@interface AppDelegate ()<BMKLocationServiceDelegate>
{
    BMKMapManager *_mapManager;
    BMKLocationService *locService; // 百度定位
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HXKSManager *manager = [HXKSManager manager];
    manager.releaseMode = NO;
    
    ProfileViewController *side = [[ProfileViewController alloc] init];
    HTHomeViewCotroller *content = [[HTHomeViewCotroller alloc] init];
    self.mainVC = [[HTNavigationController alloc] initWithRootViewController:content];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:side andMainView:self.mainVC];
    self.LeftSlideVC.closed = YES;
    [self.LeftSlideVC setPanEnabled:NO];
    
    HXKSLoginViewController *vc = [[HXKSLoginViewController alloc] init];
    HTNavigationController *nvc = [[HTNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController =nvc ;
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
    locService = [[BMKLocationService alloc] init];
    locService.delegate = self;
    [locService startUserLocationService];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [locService stopUserLocationService];
    DLog(@"百度地图定位成功");
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    DLog(@"%@百度地图定位失败@",error);
}



@end
