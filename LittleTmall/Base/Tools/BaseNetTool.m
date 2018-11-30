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
    
        NSString *tokenStr = responseObject[@"token"];
        DBLoginModel *model = [DBLoginModel yy_modelWithDictionary:responseObject[@"userInfo"]];
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
        NSMutableArray *modelArr = [DBAddressModel modelWithDicArr:responseObject];
        block(modelArr, nil);
        
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)SaveAddressParams:(NSDictionary *)params block:(void (^)(DBAddressModel *, NSError *))block
{
    
    [BaseNetService PostWithUrl:AddressSaveUrl parameters:params success:^(id responseObject) {
        DBAddressModel *model = [DBAddressModel yy_modelWithDictionary:responseObject];
        block(model, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)DeleteAddressParams:(NSDictionary *)params block:(void (^)(id, NSError *))block
{
    [BaseNetService PostWithUrl:AddressDeleteUrl parameters:params success:^(id responseObject) {
        block(responseObject, nil);
    } failure:^(NSError *error) {
        block(nil , error);
    }];
}

+  (void)GetCarListParams:(NSDictionary *)params block:(void (^)(DBCartModel *, NSError *))block
{
    [BaseNetService PostWithUrl:CarBuyUrl parameters:params success:^(id responseObject) {
        DBCartModel *model = [DBCartModel yy_modelWithDictionary:responseObject];
        model.couponInfoList = [NSArray yy_modelArrayWithClass:[DBCouponInfoListModel class] json:model.couponInfoList];
        model.cartList = [NSArray yy_modelArrayWithClass:[DBCarListModel class] json:model.cartList];
        
        model.cartTotalModel = [DBCartTotalModel yy_modelWithDictionary:model.cartTotal];
        block(model, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)CarListDeleteParams:(NSDictionary *)params block:(void (^)(DBCartModel *, NSError *))block
{
    [BaseNetService PostWithUrl:CarDeleteUrl parameters:params success:^(id responseObject) {
        DBCartModel *model = [DBCartModel yy_modelWithDictionary:responseObject];
        model.cartTotalModel = [DBCartTotalModel yy_modelWithDictionary:model.cartTotal];
        block(model, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)GetCarCheckParams:(NSDictionary *)params block:(void (^)(DBCartModel *, NSError *))block
{
    [BaseNetService PostWithUrl:CarCheckUrl parameters:params success:^(id responseObject) {
        DBCartModel *model = [DBCartModel yy_modelWithDictionary:responseObject];
        model.cartTotalModel = [DBCartTotalModel yy_modelWithDictionary:model.cartTotal];
        block(model, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)CarNumPickParams:(NSDictionary *)params block:(void (^)(DBCartModel *, NSError *))block
{
    [BaseNetService PostWithUrl:CarNumUpdateUrl parameters:params success:^(id responseObject) {
       
        block(nil, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)GetVerifyOrderParams:(NSDictionary *)params block:(void (^)(DBVerifyOrderModel *, NSError *))block
{
    [BaseNetService PostWithUrl:CarCheckOutUrl parameters:params success:^(id responseObject) {
        DBVerifyOrderModel *model = [DBVerifyOrderModel yy_modelWithJSON:responseObject];
        model.checkedAddressModel = [DBAddressModel modelWithDict:model.checkedAddress];
        model.checkedGoodsList = [NSArray yy_modelArrayWithClass:[DBCarListModel class] json:model.checkedGoodsList];
        block(model, nil);
    } failure:^(NSError *error) {
        
        block(nil, error);
    }];
}

+ (void)GetMineParams:(NSDictionary *)params block:(void (^)(NSString *, NSError *))block
{
    [BaseNetService PostWithUrl:MineUrl parameters:params success:^(id responseObject) {
        NSString *coinStr = responseObject;
        block(coinStr, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)GetOrderListParams:(NSDictionary *)params block:(void (^)(NSArray <DBOrderListModel *>*, NSError *))block
{
    [BaseNetService PostWithUrl:OrderListUrl parameters:params success:^(id responseObject) {
        NSArray *orderLists = [NSArray yy_modelArrayWithClass:[DBOrderListModel class] json:responseObject[@"data"]];
        block(orderLists, nil);
    } failure:^(NSError *error) {
        block(nil, error);
    }];
}

+ (void)SignoutParams:(NSDictionary *)params block:(void (^)(id, NSError *))block
{
    [BaseNetService PostWithUrl:SignoutUrl parameters:params success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}
+(void)OpinionFeedbackParams:(NSDictionary *)params block:(void(^)(id response,NSError *error))block{
    [BaseNetService PostWithUrl:FeedBackUrl parameters:params success:^(id responseObject) {
        block(responseObject,nil);
    } failure:^(NSError *error) {
        block(nil,error);
    }];
    
}

#pragma mark -- other --

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError =nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
