//
//  DBAddressModel.h
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAddressModel : NSObject
// 是否为默认地址
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *telNumber;
// 北京
@property (nonatomic, copy) NSString *provinceName;
// 朝阳区
@property (nonatomic, copy) NSString *cityName;
// 三环以内
@property (nonatomic, copy) NSString *countyName;
// 详细地址：马家堡西里1号楼1单元xxx
@property (nonatomic, copy) NSString *detailInfo;
// 地址全拼：北京朝阳区三环以内
@property (nonatomic, copy) NSString *full_region;
// 完整地址
@property (nonatomic, copy) NSString *full_address;

+ (NSMutableArray *)modelWithDicArr:(NSArray *)dicArr;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
