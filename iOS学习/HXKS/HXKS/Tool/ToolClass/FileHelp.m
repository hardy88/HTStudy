//
//  ASFileManager.m
//
//
//  Created by hardy on 16/5/24.
//  Copyright © 2016年 Hardy Hu. All rights reserved.
//

#import "FileHelp.h"
#import "ZipArchive.h"

@implementation FileHelp

+(BOOL)toZip:(NSString*)zipPath
{
    ZipArchive *zip = [[ZipArchive alloc] init];
    
    return  [zip CreateZipFile2:zipPath];
}

+ (BOOL)unzipFileFromzipPath:(NSString*)zipPath toUnzipPath:(NSString*)unzipPath
{
    BOOL result = NO;
    ZipArchive *zip = [[ZipArchive alloc] init];
    
    if ([zip UnzipOpenFile:zipPath])
    {
        result = [zip UnzipFileTo:unzipPath overWrite:YES];
        if (!result) {
            NSLog(@"解压失败");
        }
        else
        {
            NSLog(@"解压成功");
        }
        [zip UnzipCloseFile];
    }
    return result;
}

@end
