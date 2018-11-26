//
//  DBTool.m
//  LittleTmall
//
//  Created by 魏志军 on 2018/11/26.
//  Copyright © 2018 com.qzxq. All rights reserved.
//

#import "DBTool.h"

@implementation DBTool
+ (BOOL)isNUllOrIsEmptyWith:(id)object{
    if([object isEqual:@""] || !object){
        return YES;
    }
    return NO;
}

@end
