//
//  BaseModel.h
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

+ (NSMutableArray *)modelWithDicArr:(NSArray *)dicArr;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
