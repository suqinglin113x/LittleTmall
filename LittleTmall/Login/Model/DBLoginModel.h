//
//  DBLoginModel.h
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "BaseModel.h"

@interface DBLoginModel : BaseModel <NSCoding>
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *token;
@end
