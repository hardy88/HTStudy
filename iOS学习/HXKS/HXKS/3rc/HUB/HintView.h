//
//  HintView.h
//  HomeLinked
//
//  Created by OSX102 on 15-3-27.
//  Copyright (c) 2015年 Huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HintView : UIView

- (instancetype)initWith:(NSString*)message;

- (void)showInView:(UIView*)view;

@end
