//
//  BaseUserTool.m
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseUserTool.h"
#import "DBLoginModel.h"

#define kUserModel          @"kUserModel"

@implementation BaseUserTool

+ (void)saveUserInfo:(DBLoginModel *)info
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserModel];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)deleteUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserModel];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (DBLoginModel *)userInfo
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kUserModel];
    DBLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}

+ (NSString *)getToken
{
    DBLoginModel *model = [BaseUserTool userInfo];
    DBLog(@"TOKEN:%@", model.token);
    return model.token;
}

+ (NSString *)getUserId
{
    DBLoginModel *model = [BaseUserTool userInfo];
    return model.userId;
}

@end
