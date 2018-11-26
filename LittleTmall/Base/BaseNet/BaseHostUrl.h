//
//  BaseHostUrl.h
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#ifndef BaseHostUrl_h
#define BaseHostUrl_h

#define DBBaseUrl       @"http://192.168.0.11:6101/platform"

//#define DBBaseUrl       @"http://106.75.99.126:6302/platform"

/** 快速登录api*/
#define LoginUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/auth/login_by_mobile"]

/** 短信SMSapi*/
#define SendSMSUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/sendSms"]

/** 地址列表*/
#define AddressListUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/address/list"]

/** 保存地址*/
#define AddressSaveUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/address/save"]

/** 删除地址*/
#define AddressDeleteUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/address/delete"]

/** 购物车列表*/
#define CarBuyUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/cart/index"]

/** 购物车删除*/
#define CarDeleteUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/cart/delete"]

/** 购物车删除*/
#define CarCheckUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/cart/checked"]

/** 去结算*/
#define CarCheckOutUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/cart/checkout"]

/** 我的*/
#define MineUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/user/userAccount"]

/** 我的订单*/
#define OrderListUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/order/list"]

/** 退出*/
#define SignoutUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@""]




#endif /* BaseHostUrl_h */
