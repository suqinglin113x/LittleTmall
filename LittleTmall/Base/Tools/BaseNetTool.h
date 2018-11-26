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
#import "DBCartModel.h"
#import "DBOrderListModel.h"


@interface BaseNetTool : NSObject

/** 快速登录*/
+ (void)GetLoginWithParams:(NSDictionary *)params block:(void(^)(DBLoginModel *loginModel,NSError *error))block;

/** 短信验证码*/
+ (void)GetSMSWithParams:(NSDictionary *)params block:(void(^)(id response,NSError *error))block;

/** 地址列表*/
+ (void)GetAddressListParams:(NSDictionary *)params block:(void(^)(NSMutableArray <DBAddressModel *>*modelArr, NSError *error))block;

/** 保存地址*/
+ (void)SaveAddressParams:(NSDictionary *)params block:(void(^)(DBAddressModel *model, NSError *error))block;

/** 删除地址*/
+ (void)DeleteAddressParams:(NSDictionary *)params block:(void(^)(id response, NSError *error))block;

/** 购物车列表*/
+ (void)GetCarListParams:(NSDictionary *)params block:(void(^)(DBCartModel *model, NSError *error))block;

/** 购物车删除*/
+ (void)CarListDeleteParams:(NSDictionary *)params block:(void(^)(DBCartModel *model, NSError *error))block;

/** 购物车选中否*/
+ (void)GetCarCheckParams:(NSDictionary *)params block:(void(^)(DBCartModel *model, NSError *error))block;

/** 我的*/
+ (void)GetMineParams:(NSDictionary *)params block:(void(^)(NSString *coinStr, NSError *error))block;

/** 订单列表*/
+ (void)GetOrderListParams:(NSDictionary *)params block:(void(^)(NSArray <DBOrderListModel *> *orderLists, NSError *error))block;

/** 退出*/
+ (void)SignoutParams:(NSDictionary *)params block:(void(^)(id response, NSError *error))block;






@end
