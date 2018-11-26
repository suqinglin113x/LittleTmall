//
//  NSString+DBTool.h
//  LittleTmall
//
//  Created by 魏志军 on 2018/11/26.
//  Copyright © 2018 com.qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DBTool)
- (BOOL)isAllSame;
- (BOOL)validLengthMin:(NSInteger)min andMax:(NSInteger)max;
- (BOOL)stringContainsEmoji;
- (BOOL)isMobileNumber;
- (BOOL)isPasswordFormat;
@end

NS_ASSUME_NONNULL_END
