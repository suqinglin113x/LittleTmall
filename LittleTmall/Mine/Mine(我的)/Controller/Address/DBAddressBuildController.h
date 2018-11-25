//
//  DBAddressBuildController.h
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBBaseViewController.h"

@class DBAddressModel;

@interface DBAddressBuildController : DBBaseViewController

@property (nonatomic, strong) DBAddressModel *addressModel;
/** 是否是新建地址*/
@property (nonatomic, assign) BOOL isNewBuild;

@property (nonatomic, copy) void (^saveAddressBlock)(DBAddressModel *model);
@end
