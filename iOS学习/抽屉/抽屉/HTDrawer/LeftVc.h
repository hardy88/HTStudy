//
//  LeftVc.h
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftVcDelegate <NSObject>

-(void)LeftVcClick;

@end

@interface LeftVc : UIViewController

@property(nonatomic,assign)id<LeftVcDelegate> delegate;


@end
