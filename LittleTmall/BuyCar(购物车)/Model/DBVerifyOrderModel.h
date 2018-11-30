//
//  DBVerifyOrderModel.h
//  LittleTmall
//
//  Created by Adam on 2018/11/27.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseModel.h"

@interface DBVerifyOrderModel : BaseModel
@property (nonatomic, copy) NSString *actualPrice;
@property (nonatomic, copy) NSString *orderTotalPrice;
@property (nonatomic, copy) NSString *couponPrice;
@property (nonatomic, copy) NSString *freightPrice;
@property (nonatomic, copy) NSString *goodsTotalPrice;
@property (nonatomic, strong) NSDictionary *checkedAddress;
@property (nonatomic, strong) DBAddressModel *checkedAddressModel;
@property (nonatomic, strong) NSArray<DBCarListModel *> *checkedGoodsList;
@end
