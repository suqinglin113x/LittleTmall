//
//  BaseUserTool.h
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBLoginModel;

@interface BaseUserTool : NSObject

+ (void)saveUserInfo:(DBLoginModel *)info;
+ (void)deleteUserInfo;
+ (DBLoginModel *)userInfo;
+ (NSString *)getToken;
+ (NSString *)getUserId;
@end
