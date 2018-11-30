//
//  DBVerifyOrderBottom.m
//  LittleTmall
//
//  Created by Adam on 2018/11/29.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBVerifyOrderBottom.h"

@interface DBVerifyOrderBottom ()
@property (nonatomic, strong) UILabel *moneyL;
@property (nonatomic, strong) UIButton *payBtn;
@end

@implementation DBVerifyOrderBottom

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addOrderBotomer];
    }
    return self;
}


- (void)addOrderBotomer
{
    self.moneyL = [[UILabel alloc] init];
    [self addSubview:self.moneyL];
    self.moneyL.text = @"实付:    ¥0.00";
    self.moneyL.textColor = kMainColor;
    self.moneyL.textAlignment = 0;
    self.moneyL.font = kFont(17);
    
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.payBtn];
    [self.payBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [self.payBtn az_setGradientBackgroundWithColors:@[kMainBeginColor, kMainEndColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payBtn.titleLabel setFont:kFont(17)];
    [self.payBtn addTarget:self action:@selector(toPayMoney) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)layoutSubviews
{
    CGFloat margin = 15 *kScale;
    self.moneyL.frame = CGRectMake(margin, 0, 260 *kScale, self.height);
    self.payBtn.frame = CGRectMake(self.moneyL.right, 0, self.width - self.moneyL.width, self.height);
    
}

#pragma mark -- action --

/** 付款*/
- (void)toPayMoney
{
    DBLog(@"付款吧，款爷");
    
}

@end
