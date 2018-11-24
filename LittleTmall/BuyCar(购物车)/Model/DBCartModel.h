//
//  DBCartModel.h
//  LittleTmall
//
//  Created by Adam on 2018/11/24.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseModel.h"
@class DBCartTotalModel;
@interface DBCartModel : BaseModel
@property (nonatomic, strong) NSDictionary *cartTotal;
@property (nonatomic, strong) NSArray *couponInfoList;
@property (nonatomic, strong) NSArray *cartList;
@property (nonatomic, strong) DBCartTotalModel *cartTotalModel;
@end

@interface DBCarListModel:DBCartModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *retail_price;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *checked;
@property (nonatomic, copy) NSString *list_pic_url;
@property (nonatomic, copy) NSString *good_url;
@end

@interface DBCouponInfoListModel :DBCartModel
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *type;
@end

@interface DBCartTotalModel :BaseModel
@property (nonatomic, copy) NSString *goodsCount;
@property (nonatomic, copy) NSString *checkedGoodsCount;
@property (nonatomic, copy) NSString *goodsAmount;
@property (nonatomic, copy) NSString *checkedGoodsAmount;
@end
