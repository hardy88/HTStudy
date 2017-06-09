//
//  ASFileManager.h
//  
//
//  Created by hardy on 16/5/24.
//  Copyright © 2016年 Hardy Hu. All rights reserved.

/*!
 *  文件操作工具
 */

#import <Foundation/Foundation.h>

@interface FileHelp : NSObject
/*!
 *  压缩文件为zip格式
 *
 *  @param zipPath 存放zip压缩包的路径
 *
 *  @return YES -- 压缩成功  NO -- 压缩失败
 */
+(BOOL)toZip:(NSString*)zipPath;
/*!
 *  解压zip文件
 *
 *  @param zipPath   zip文件路径
 *  @param unzipPath zip文件解压后的路径
 *
 *  @return YES -- 解压成功 NO -- 解压失败
 */
+(BOOL)unzipFileFromzipPath:(NSString*)zipPath toUnzipPath:(NSString*)unzipPath;

@end
