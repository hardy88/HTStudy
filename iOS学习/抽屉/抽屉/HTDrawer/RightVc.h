//
//  RightVc.h
//  抽屉
//
//  Created by hardy on 16/9/23.
//  Copyright © 2016年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightVcDelegate <NSObject>

-(void)RightVcClick;

@end

@interface RightVc : UIViewController

@property(nonatomic,copy)NSString *message;


@property(nonatomic,assign)id<RightVcDelegate> delegate;

@end
