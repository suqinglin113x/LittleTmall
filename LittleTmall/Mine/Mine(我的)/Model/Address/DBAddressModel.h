//
//  DBAddressModel.h
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAddressModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, copy) NSString *addressStr;

+ (NSMutableArray *)modelWithDicArr:(NSArray *)dicArr;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
