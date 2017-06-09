//
//  ASCityPickeView.h
//  hxxdj
//
//  Created by aisino on 16/3/25.
//  Copyright © 2016年 aisino. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HTCityPickeView : UIView

- (void)show:(void (^)(NSString *sheng, NSString *shenCode, NSString *city, NSString *cityCode, NSString *qu, NSString *quCode))callBack;

- (void)remove;

@end
