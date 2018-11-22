//
//  Macro.h
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScale [[UIScreen mainScreen] bounds].size.width / 375.0
#define kScaleY [[UIScreen mainScreen] bounds].size.width / 667.0

#define kFont(size) [UIFont systemFontOfSize:size * kScale]

#define UIColorFromRGB(r, g, b) [UIColor colorWithRed: (r/255.0) green: (g/255.0) blue: (b/255.0) alpha:1]
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kMainColor UIColorFromHex(0xae3e3c) // 暗红
#define kBgColor UIColorFromRGB(244, 244, 244) // 白灰色
#define kTextColor UIColorFromHex(0x888888) // 黑灰色

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define kTabBarHeigth  49
#define kNavBarAndStatusBarHeight (kIsiPhoneX? 88: 64)


#define kIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 弱引用
#define DBWeakSelf __weak typeof(self) weakSelf = self;

// log
#ifndef __OPTIMIZE__
#define DBLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DBLog(...){}
#endif

// const string
#define kNetError @"网络请求错误,请稍后再试"
#define kNoData @"无记账记录"



#endif /* Macro_h */
