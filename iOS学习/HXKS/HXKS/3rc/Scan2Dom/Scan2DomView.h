//
//  Scan2Dom.h
//  hxszy
//
//  Created by hardy on 16/6/16.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Scan2DomView;

@protocol Scan2DomDelegate <NSObject>
// 采集到二维码信息后回调
-(void)scanView:(Scan2DomView*)scanView codeInfo:(NSString*)codeInfo;

@end

@interface Scan2DomView : UIView

@property(nonatomic,weak)id<Scan2DomDelegate> delegate;


/*!
 *  开始扫描
 */
-(void)start;
/*!
 *  结束扫描
 */
-(void)stop;
@end
