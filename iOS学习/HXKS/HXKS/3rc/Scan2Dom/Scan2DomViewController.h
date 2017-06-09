//
//  Scan2DomViewController.h
//  hxszy
//
//  Created by hardy on 16/6/16.
//  Copyright © 2016年 Hardy Hu. All rights reserved.

/*!
 *  二维码扫码
 */

#import <UIKit/UIKit.h>

@class Scan2DomViewController;

@protocol Scan2DomViewControllerDelegate <NSObject>
/*!
 *  扫描信息
 *
 *  @param scanController 扫描viewController
 *  @param codeStr        扫描后的信息
 */
-(void)scanCodeController:(Scan2DomViewController*)scanController codeInfo:(NSString*)codeStr;

@end

@interface Scan2DomViewController : UIViewController

@property(nonatomic,weak)id<Scan2DomViewControllerDelegate> delegate;


@end
