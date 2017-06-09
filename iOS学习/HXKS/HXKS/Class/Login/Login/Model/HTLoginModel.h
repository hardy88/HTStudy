//
//  HTLoginModel.h
//  HTHXBB
//
//  Created by hardy on 2017/3/2.
//  Copyright © 2017年 hardy. All rights reserved.
//

#import "HTBaseModel.h"

@interface HTLoginModel : HTBaseModel

/*       登录信息      */
@property (nonatomic, copy) NSString *dksypt;

@property (nonatomic, copy) NSString *msg;
// 企业信息
@property (nonatomic, strong) NSDictionary *qyxxPo;

@property (nonatomic, copy) NSString *success;
// 用户信息
@property (nonatomic, strong)NSDictionary *yhPo;
// 用户积分
@property (nonatomic, copy) NSString *yhjf;

@property (nonatomic, strong) NSDictionary *yhmrdz;

@end

/*       用户信息      */
@interface HTLoginYonghuInfoModel : HTBaseModel

@property (nonatomic, copy) NSString *createdate;

@property (nonatomic, copy) NSString *delflag;

@property (nonatomic, copy) NSString *dlcs;
// 登录密码
@property (nonatomic, copy) NSString *dlmm;

@property (nonatomic, copy) NSString *dlsbid;

@property (nonatomic, copy) NSString *dlsblx;

@property (nonatomic, copy) NSString *dlyhm;
// id -> yhid 用户id
@property (nonatomic, copy) NSString *yhId;

@property (nonatomic, copy) NSString *sbdlcs;

@property (nonatomic, copy) NSString *scdlsj;

@property (nonatomic, copy) NSString *sfzx;

@property (nonatomic, copy) NSString *sjh;

@property (nonatomic, copy) NSString *sncode;
// 头像url
@property (nonatomic, copy) NSString *tx;
// 用户名称
@property (nonatomic, copy) NSString *yhmc;
@end

/*       企业信息      */
@interface HTLoginQiyeInfoModel : HTBaseModel

@property (nonatomic, copy) NSString *createdate;

@property (nonatomic, copy) NSString *delflag;

@property (nonatomic, copy) NSString *fjh;

@property (nonatomic, copy) NSString *hth;
// id  -> qyId
@property (nonatomic, copy) NSString *qyId;

@property (nonatomic, copy) NSString *khhmc;

@property (nonatomic, copy) NSString *qydh;

@property (nonatomic, copy) NSString *qydz;

@property (nonatomic, copy) NSString *qymc;

@property (nonatomic, copy) NSString *sfmr;

@property (nonatomic, copy) NSString *sfxyh;

@property (nonatomic, copy) NSString *swdjh;

@property (nonatomic, copy) NSString *updatedate;

@property (nonatomic, copy) NSString *yhzh;

@end


/*       用户 mr 信息      */
@interface HTLoginYhmrdzModel : HTBaseModel

@property (nonatomic, copy) NSString *createdate;

@property (nonatomic, copy) NSString *delflag;
// id ->mrdzId
@property (nonatomic, copy) NSString *mrdzId;

@property (nonatomic, copy) NSString *lxrsjh;

@property (nonatomic, copy) NSString *quxian;

@property (nonatomic, copy) NSString *quxianval;

@property (nonatomic, copy) NSString *sfmr;

@property (nonatomic, copy) NSString *shen;

@property (nonatomic, copy) NSString *shenval;

@property (nonatomic, copy) NSString *shi;

@property (nonatomic, copy) NSString *shival;

@property (nonatomic, copy) NSString *sjrxm;

@property (nonatomic, copy) NSString *updatedate;

@property (nonatomic, copy) NSString *xxdz;

@property (nonatomic, copy) NSString *yhid;

@property (nonatomic, copy) NSString *yzbm;

@end
