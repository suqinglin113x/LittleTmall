//
//  BaseNetTool.m
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseNetTool.h"

@implementation BaseNetTool

+ (void)GetLoginWithParams:(NSDictionary *)params block:(void (^)(DBLoginModel *,NSError *error))block
{
    [BaseNetService PostWithUrl:LoginUrl parameters:params success:^(id responseObject) {
    
        NSString *tokenStr = responseObject[@"data"][@"token"];
        DBLoginModel *model = [DBLoginModel yy_modelWithDictionary:responseObject[@"data"][@"userInfo"]];
        model.token = tokenStr;
        [BaseUserTool saveUserInfo:model];
        
        block(model, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)GetSMSWithParams:(NSDictionary *)params block:(void (^)(id, NSError *))block
{
    [BaseNetService PostWithUrl:SendSMSUrl parameters:params success:^(id responseObject) {
    
        block(responseObject, nil);
    
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)GetAddressListParams:(NSDictionary *)params block:(void (^)(NSMutableArray<DBAddressModel *> *, NSError *))block
{
    [BaseNetService PostWithUrl:AddressListUrl parameters:params success:^(id responseObject) {
        NSMutableArray *modelArr = [DBAddressModel modelWithDicArr:responseObject[@"data"]];
        block(modelArr, nil);
        
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)SaveAddressParams:(NSDictionary *)params block:(void (^)(DBAddressModel *, NSError *))block
{
    [BaseNetService PostWithUrl:SaveAddressUrl parameters:params success:^(id responseObject) {
        DBAddressModel *model = [DBAddressModel yy_modelWithDictionary:responseObject[@"data"]];
        block(model, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)DeleteAddressParams:(NSDictionary *)params block:(void (^)(id, NSError *))block
{
    [BaseNetService PostWithUrl:DeleteAddressUrl parameters:params success:^(id responseObject) {
        block(responseObject, nil);
    } failure:^(NSError *error) {
        block(nil , error);
    }];
}

+  (void)GetCarListParams:(NSDictionary *)params block:(void (^)(DBCartModel *, NSError *))block
{
    [BaseNetService PostWithUrl:CarBuyUrl parameters:params success:^(id responseObject) {
        DBCartModel *model = [DBCartModel yy_modelWithDictionary:responseObject[@"data"]];
        model.couponInfoList = [NSArray yy_modelArrayWithClass:[DBCouponInfoListModel class] json:model.couponInfoList];
        model.cartList = [NSArray yy_modelArrayWithClass:[DBCarListModel class] json:model.cartList];
        
//        model.cartTotalModel = [DBCartTotalModel yy_modelWithDictionary:model.cartTotal];
        block(model, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}
@end
