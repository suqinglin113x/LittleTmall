//
//  DBVerifyOrderHeader.h
//  LittleTmall
//
//  Created by Adam on 2018/11/27.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DBVerifyOrderHeaderDelegate <NSObject>
- (void)chooseAddress;

- (void)chooseCoupon;
@end
@interface DBVerifyOrderHeader : UIView
@property (nonatomic, strong) DBVerifyOrderModel *orderModel;
@property (nonatomic, weak) id<DBVerifyOrderHeaderDelegate> delegate;
@end
