//
//  UITableView+EmptyDataView.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "UITableView+EmptyDataView.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong) UIView *noDataV;

@end

@implementation UITableView (EmptyDataView)

- (void)setNoDataV:(UIView *)noDataV
{
    objc_setAssociatedObject(self, @"noDataView", noDataV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)noDataV
{
    return objc_getAssociatedObject(self, @"noDataView");
}

- (void)setNo_delegate:(id<UITableViewNoDataDelegate>)no_delegate
{
    objc_setAssociatedObject(self, @"no_dele", no_delegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id<UITableViewNoDataDelegate>)no_delegate
{
    return objc_getAssociatedObject(self, @"no_dele");
}

/** 展示暂无数据页面*/
- (void)showNoDataViewImg:(NSString *)imageName hintText:(NSString *)hint btnTitle:(NSString *)btnTitle
{
    if (self.noDataV) {
        return;
    }
    self.noDataV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)];
    self.noDataV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.noDataV];
    
    UIButton *imageView = [[UIButton alloc] init];
    imageView.frame = CGRectMake(0, self.bounds.size.height *0.3, 50, 50);
    imageView.centerX = self.noDataV.centerX;
    [imageView setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.noDataV addSubview:imageView];
    
    UILabel *aRowSmallText = [[UILabel alloc] init];
    aRowSmallText.text = hint;
    aRowSmallText.textAlignment = 1;
    aRowSmallText.frame = CGRectMake(0, imageView.bottom + 15 *kScale, 300, 30);
    aRowSmallText.centerX = self.centerX;
    aRowSmallText.font = [UIFont systemFontOfSize:14 *kScale];
    aRowSmallText.textColor = UIColorFromHex(0x999999);
    [self.noDataV addSubview:aRowSmallText];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, aRowSmallText.bottom + 15 *kScale, 170  *kScale, 40 *kScale);
    btn.centerX = self.centerX;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16 *kScale]];
    btn.layer.cornerRadius = 4 *kScale;
    [btn addTarget:self action:@selector(noDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    if (btnTitle.length != 0) {
        [self.noDataV addSubview:btn];
    }
}

/** 隐藏暂无数据页面*/
- (void)hideNoDataView
{
    if (self.noDataV) {
        [self.noDataV removeFromSuperview];
        self.noDataV = nil;
    } else {
        
    }
}

- (void)noDataBtnClick:(UIButton *)btn
{
    DBLog(@"%s", __func__);
    if ([self.no_delegate respondsToSelector:@selector(noDataViewClick)]) {
        [self.no_delegate noDataViewClick];
    }
}


@end
