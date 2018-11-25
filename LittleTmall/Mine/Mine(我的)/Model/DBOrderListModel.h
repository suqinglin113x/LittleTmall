//
//  DBOrderListModel.h
//  LittleTmall
//
//  Created by Adam on 2018/11/25.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseModel.h"

@interface DBOrderListModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *order_status;
@property (nonatomic, copy) NSString *pay_status;
@property (nonatomic, copy) NSString *actual_price;
@property (nonatomic, copy) NSString *order_status_text;
@end
