//
//  BaseNetService.m
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseNetService.h"
#import <AFNetworking.h>

@implementation BaseNetService

+ (AFHTTPSessionManager *)manager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return manager;
}

 + (void)PostWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    DBLog(@"网络请求========url:%@\n;parameters=========:%@\n",urlString, parameters);
    
    [[BaseNetService manager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DBLog(@"返回值========：%@", responseObject);
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DBLog(@"网络请求error========url:%@\n%@",task.response.URL,error);
        failureBlock(error);
        
    }];
}
@end
