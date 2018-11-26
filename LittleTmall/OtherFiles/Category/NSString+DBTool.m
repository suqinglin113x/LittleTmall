//
//  NSString+DBTool.m
//  LittleTmall
//
//  Created by 魏志军 on 2018/11/26.
//  Copyright © 2018 com.qzxq. All rights reserved.
//

#import "NSString+DBTool.h"

@implementation NSString (DBTool)
- (BOOL)isAllSame{
    //是否全部一样 YES 全部一样  NO 不一样
    BOOL isSameYesNO = NO;
    for (int i = 0; i < self.length; i ++) {
        if(i > 0){
            NSString *preStr = [self substringWithRange:NSMakeRange(i - 1, 1)];
            NSString *currentStr = [self substringWithRange:NSMakeRange(i, 1)];
            
            if(![preStr isEqual:currentStr]){
                break;
            }
            if(i == self.length - 1){
                isSameYesNO = YES;
            }
        }
    }
    return isSameYesNO;
}

- (BOOL)isNUllOrIsEmpty{
    if([self isEqual:@""] || !self){
        return YES;
    }
    return NO;
}

- (BOOL)validLengthMin:(NSInteger)min andMax:(NSInteger)max{
    //[\u4e00-\u9fa5_a-zA-Z0-9_]{4,10}  //^[\u4e00-\u9fa5_a-zA-Z]{%d,%d}$)
    if(!self){
        return NO;
    }
    NSString *string = self;
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *regex =[NSString stringWithFormat:@"(^[\u4e00-\u9fa5_a-zA-Z0-9]{%ld,%ld}$)",min,max];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

- (BOOL)stringContainsEmoji{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

- (NSString *)dealWithstrValidity{
    if([self isNUllOrIsEmpty]){
        return @"";
    }
    NSArray *tmpStrValidityAry = [self componentsSeparatedByString:@"-"];
    
    //身份证有效截止日期
    NSString *validityExpirationDate = [tmpStrValidityAry lastObject];
    //格式化截止日期
    NSString *formattingValidityExpirationDate = @"";
    if ([validityExpirationDate isEqualToString:@"长期"]) {
        formattingValidityExpirationDate = @"2100-01-01";
    }else{
        
       // formattingValidityExpirationDate = [NSDate convertDateFormatter:@"yyyyMMdd" targetFormatter:@"yyyy-MM-dd" dateString:validityExpirationDate];
    }
    //ZHLog(@"%@",formattingValidityExpirationDate);
    return formattingValidityExpirationDate;
}

//正则判断手机号码地址格式
- (BOOL)isMobileNumber{
    
    if([self isNUllOrIsEmpty]){
        return NO;
    }
    NSString *all = @"^1([3-9][0-9])\\d{8}$";
    NSPredicate *regextestct1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", all];
    return [regextestct1 evaluateWithObject:self];
}

- (BOOL)isPasswordFormat{
    NSString *CM = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [regextestcm evaluateWithObject:self];
    
}
@end
