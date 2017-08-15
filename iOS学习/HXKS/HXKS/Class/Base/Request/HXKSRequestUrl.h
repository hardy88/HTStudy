//
//  HXKSUrl.h
//  HXKS
//
//  Created by hardy on 2017/7/27.
//  Copyright © 2017年 胡海涛. All rights reserved.
//


/*
 * 网络请求URL
 */


// post 请求基本URL
#define POST_BASE_URL @"http://192.168.1.202:9101"


/***********************************登录注册接口***************************************/

// 登录
#define HXKS_LOGINURL  @"/login"
// 登出
#define HXKS_LOGOUTURL @"/logout"
// 注册发送手机验证码
#define HXKS_LOGIN_VALIDATEURL @"/bindPhone"
// 注册
#define HXKS_LOGIN_REGISTERURL @"/regApp"
// 旧密码修改密码
#define HXKS_UPDATEPASSWORD_MODEFYURL @"/updatePass"
// 短信验证码修改密码
#define HXKS_MESSAGEPASSWORD_MODIFYURL @"/yzmPass"
// 忘记密码发送手机验证码
#define HXKS_FORGETPARRWORD_SENTMESSAGEURL @"/passYzmSend"
// app锁匠设置密码发送短信
#define HXKS_FORGETPASSWORD_RESETPSW_URL @"/dxyzApp"





/***********************************订单接口***************************************/

#define  HXKS_ORDER_ORDERLIST_URL @"//order/getOrderList.do"  // 获取订单列表

#define  HXKS_ORDER_DONEORDER_URL @"//order/sjCompleteOrder.do" // 锁匠确定完成订单

#define  HXKS_ORDER_ACCEPTORDER_URL @"//order/acceptOrder.do"  // 锁匠接单

#define  HXKS_ORDER_CANCELORDER_URL @"//order/sjCancelOrder.do" // 锁匠取消接单


