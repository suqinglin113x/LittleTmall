//
//  DBLoginModel.m
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBLoginModel.h"

#define kUserID         @"kUserID"
#define kMobile         @"kMobile"
#define kToken          @"kToken"
#define kNickName       @"kNickName"

@implementation DBLoginModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_token forKey:kToken];
    [aCoder encodeObject:_userId forKey:kUserID];
    [aCoder encodeObject:_mobile forKey:kMobile];
    [aCoder encodeObject:_nickName forKey:kNickName];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.token = [aDecoder decodeObjectForKey:kToken];
        self.userId = [aDecoder decodeObjectForKey:kUserID];
        self.mobile = [aDecoder decodeObjectForKey:kMobile];
        self.nickName = [aDecoder decodeObjectForKey:kNickName];
    }
    return self;
}
@end
