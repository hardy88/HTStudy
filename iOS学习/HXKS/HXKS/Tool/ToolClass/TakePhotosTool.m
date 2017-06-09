//
//  TakePhotosTool.m
//  HTHXBB
//
//  Created by hardy on 2017/3/21.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "TakePhotosTool.h"
#import <MobileCoreServices/UTCoreTypes.h>

@implementation TakePhotosTool

+ (void)takePhotoWithCamera:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)vc
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        photoPicker.allowsEditing = YES;
        photoPicker.delegate = vc;
        photoPicker.showsCameraControls  = YES;
        [vc presentViewController:photoPicker animated:YES completion:nil];
    }
}
+ (void)pickPhotosFromPhotoLibrary:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)vc
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 选择要显示的资源类型
//        photoPicker.mediaTypes = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie];
        photoPicker.allowsEditing = YES;
        photoPicker.delegate = vc;
        [vc presentViewController:photoPicker animated:YES completion:nil];
    }
}
+ (void)pickPhotosFromSavedPhotosAlbum:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)vc
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        photoPicker.allowsEditing = YES;
        photoPicker.delegate = vc;
        [vc presentViewController:photoPicker animated:YES completion:nil];
    }
}

@end
