//
//  DBAddressModel.m
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBAddressModel.h"

@implementation DBAddressModel


+ (NSMutableArray *)modelWithDicArr:(NSArray *)dicArr
{
    NSMutableArray *temArr = [NSMutableArray array];
    if (dicArr && [dicArr isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in dicArr) {
            DBAddressModel *model = [DBAddressModel modelWithDict:dict];
           
            [temArr addObject:model];
        }
    }
    return temArr;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    dict = [self nullConvert:[dict mutableCopy]];
    DBAddressModel *model = [[DBAddressModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    model.full_address = [model.full_region stringByAppendingString:[NSString stringWithFormat:@" %@", model.detailInfo]];
    return model;
}

+ (NSDictionary *)nullConvert:(NSMutableDictionary *)dict;
{
    for (NSString *key in dict.allKeys) {
        if ([dict[key] isKindOfClass:[NSNull class]] || ([dict[key] isKindOfClass:[NSString class]] && [dict[key] containsString:@"null"])) {
            dict[key] = nil;
        }
    }
    return dict;
}
@end
