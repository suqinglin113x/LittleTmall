//
//  BaseModel.m
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+ (NSMutableArray *)modelWithDicArr:(NSArray *)dicArr
{
    NSMutableArray *temArr = [NSMutableArray array];
    if (dicArr && [dicArr isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in dicArr) {
            BaseModel *model = [BaseModel modelWithDict:dict];
            [temArr addObject:model];
        }
    }
    return temArr;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    BaseModel *model = [[BaseModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
