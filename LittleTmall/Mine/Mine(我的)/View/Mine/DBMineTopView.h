//
//  DBMineTopView.h
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MineTopViewDelegate <NSObject>
/** 头像点击代理*/
- (void)headImageVClick;

@end
@interface DBMineTopView : UIView

@property (nonatomic, copy) NSString *coinStr;
@end

NS_ASSUME_NONNULL_END
