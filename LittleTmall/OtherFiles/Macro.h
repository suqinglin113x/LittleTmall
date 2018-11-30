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
#define kScalY [[UIScreen mainScreen] bounds].size.width / 667.0

#define kFont(size) [UIFont systemFontOfSize:size * kScale]

#define UIColorFromRGB(r, g, b) UIColorFromRGBA(r, g, b, 1)
#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed: (r/255.0) green: (g/255.0) blue: (b/255.0) alpha:a/10.0]
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kMainColor UIColorFromHex(0xFF7020) // 橘黄
#define kMainBeginColor UIColorFromHex(0xF76B1C) //   起始黄色值
#define kMainEndColor   UIColorFromHex(0xFFB559) //  结束黄色值
#define kBgColor UIColorFromHex(0xF6F6F6) // 白灰色
#define kTextColor UIColorFromHex(0x333333) // 非纯黑色字体


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
