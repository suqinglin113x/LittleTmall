//
//  BaseNetTool.h
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBLoginModel.h"
#import "DBAddressModel.h"

@interface BaseNetTool : NSObject

/** 快速登录*/
+ (void)GetLoginWithParams:(NSDictionary *)params block:(void(^)(DBLoginModel *loginModel,NSError *error))block;

/** 短信验证码*/
+ (void)GetSMSWithParams:(NSDictionary *)params block:(void(^)(id response,NSError *error))block;

/** 地址列表*/
+ (void)GetAddressListParams:(NSDictionary *)params block:(void(^)(NSMutableArray <DBAddressModel *>*modelArr, NSError *error))block;

/** 保存地址*/
+ (void)SaveAddressParams:(NSDictionary *)params block:(void(^)(DBAddressModel *model, NSError *error))block;

///** 保存地址*/
//+ (void)SaveAddressParams:(NSDictionary *)params block:(void(^)(DBAddressModel *model, NSError *error))block;
//
///** 保存地址*/
//+ (void)SaveAddressParams:(NSDictionary *)params block:(void(^)(DBAddressModel *model, NSError *error))block;
//
///** 保存地址*/
//+ (void)SaveAddressParams:(NSDictionary *)params block:(void(^)(DBAddressModel *model, NSError *error))block;
//
///** 保存地址*/
//+ (void)SaveAddressParams:(NSDictionary *)params block:(void(^)(DBAddressModel *model, NSError *error))block;






@end
