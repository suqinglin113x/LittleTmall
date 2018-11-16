//
//  BaseNetService.h
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetService : NSObject

+ (void)PostWithUrl:(nonnull NSString * )urlString parameters:(nullable NSDictionary * ) parameters success:(void(^)(id responseObject))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
