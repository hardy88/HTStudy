//
//  HTOpenDoneViewController.m
//  HXKS
//
//  Created by hardy on 2017/5/17.
//  Copyright © 2017年 胡海涛. All rights reserved.
//

// vc
#import "HTOpenDoneViewController.h"

#import "ZYQAssetPickerController.h"

// view
#import "HTSeparator.h"
#import "HTOpenDoneCell.h"
#import "HTUploadImageCell.h"

// model
#import "HTOpenClockOrderModel.h"

// other
#import "TakePhotosTool.h"
#import "ProgressHUD.h"

@interface HTOpenDoneViewController ()<UITableViewDelegate,UITableViewDataSource,HTUploadImageCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,UIActionSheetDelegate>
{
    UITableView *tbView;
    
    NSMutableArray *imgArr;

}

@end

@implementation HTOpenDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupBaseView
{
    
    self.navTitle = @"完成开锁";
    [self addRightNavText:@"提交" action:@selector(openDoneToSubmit)];
    // 创建界面
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    imgArr = [NSMutableArray arrayWithCapacity:0];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    tbView.tableFooterView = [[UIView alloc] init];
    tbView.tableHeaderView =[self returnHeaderView];
    [self.view addSubview:tbView];
    
}
- (void)setBaseData
{
    // 初始化数据
}
- (void)setupRequest
{
    // 发生请求
}

- (UIView*)returnHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    return headerView;
}
- (void)openDoneToSubmit
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [HTOpenDoneCell returnCellHeight];
    }
    return [HTUploadImageCell returnCellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    if (section ==1)
    {
        return CGFLOAT_MIN;
    }
    return 15;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#ECEBF3"];
    return headerView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.section)
    {
        case 0:
        {
          HTOpenDoneCell  *doneCell = [tableView dequeueReusableCellWithIdentifier:[HTOpenDoneCell returnCellID]];
            if (!doneCell)
            {
                doneCell = [[HTOpenDoneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[HTOpenDoneCell returnCellID]];
            }
            HTOpenClockOrderModel *model = [[HTOpenClockOrderModel alloc] init];
            model.applyer = @"张先生";
            model.telStr = @"15236987415";
            model.addStr = @"安顺家园5栋505室";
            model.hsaLock = YES;
            model.lockType = @(1);
            model.timeStr = @"2017-05-20 14:24:55";
            [doneCell configCellWithModel:model];
            cell = doneCell;
        }
         break;
        case 1:
        {
            HTUploadImageCell *imgCell =[tableView dequeueReusableCellWithIdentifier:[HTUploadImageCell returnCellID]];
            if (!imgCell)
            {
                imgCell = [[HTUploadImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[HTUploadImageCell returnCellID]];
            }
            imgCell.imgArr = imgArr;
            imgCell.delegate = self;
            cell = imgCell;
        }
        break;
    }

    return cell;
}
#pragma mark --HTUploadImageCellDelegate
- (void)htUploadImageCellloadMoreImage
{

    if (imgArr.count>=2)
    {
        [ProgressHUD showInfo:@"只能添加2张图片" onView:self.view];
        [ProgressHUD hideOnView:self.view];
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册获取",nil];
    [actionSheet showInView:self.view];
}
// 本地相册照片的回调
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (assets.count >0)
    {
        for (int i=0; i<assets.count; i++)
        {
            ALAsset *asset=assets[i];
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [imgArr addObject:tempImg];
        }
    }
    if (imgArr.count > 0)
    {
        [tbView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
       NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
            [imgArr addObject:image];
        }
    
        [picker dismissViewControllerAnimated:YES completion:^{
            
            if (imgArr.count >0 )
            {
                 [tbView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
  }];
}

#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: // 拍照
            [TakePhotosTool takePhotoWithCamera:self];
            break;
        case 1:  // 从相册获取
            [self openPhotoLib];
            break;
        case 2: // 取消
            break;
    }
}
- (void)openPhotoLib
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 2-imgArr.count;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings)
                              {
                                  if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
                                  {
                                      NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                                      return duration >= 5;
                                  }
                                  else
                                  {
                                      return YES;
                                  }
                              }];
    [self presentViewController:picker animated:YES completion:NULL];
}
@end
