//
//  UITableView+EmptyDataView.h
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol UITableViewNoDataDelegate <NSObject>
@optional
- (void)noDataViewClick;

@end
@interface UITableView (EmptyDataView)

@property (nonatomic, weak) id <UITableViewNoDataDelegate> no_delegate;

/** 展示暂无数据页面*/
- (void)showNoDataViewImg:(NSString *)imageName text:(NSString *)hint btn:(NSString *)btnTitle;

/** 隐藏暂无数据页面*/
- (void)hideNoDataView;

@end

NS_ASSUME_NONNULL_END
