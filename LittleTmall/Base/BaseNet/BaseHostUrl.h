//
//  BaseHostUrl.h
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#ifndef BaseHostUrl_h
#define BaseHostUrl_h

#define DBBaseUrl @"http://192.168.0.11:6101/platform"

/** 快速登录api*/
#define LoginUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/auth/login_by_mobile"]

/** 短信SMSapi*/
#define SendSMSUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/sendSms"]

/** 地址列表*/
#define AddressListUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/address/list"]

/** 保存地址*/
#define SaveAddressUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/address/save"]

/** 删除地址*/
#define DeleteAddressUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/address/delete"]

/** 购物车列表*/
#define CarBuyUrl [NSString stringWithFormat:@"%@%@",DBBaseUrl,@"/api/cart/index"]

#endif /* BaseHostUrl_h */
