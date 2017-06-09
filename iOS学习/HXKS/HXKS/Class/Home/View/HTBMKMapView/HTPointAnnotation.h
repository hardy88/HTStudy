//
//  HTPointAnnotation.h
//  HXKS
//
//  Created by hardy on 2017/5/23.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import "HTCustomerInfoModel.h"


@interface HTPointAnnotation : BMKPointAnnotation

@property(nonatomic,strong)HTCustomerInfoModel *model;

@end
