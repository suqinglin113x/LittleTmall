//
//  QLMineTopView.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLMineTopView.h"

@interface QLMineTopView()

/**
 背景图片
 */
@property (nonatomic, strong) UIImageView *bgImageV;

/**
 用户头像
 */
@property (nonatomic, strong) UIImageView *headImageV;

/**
 用户名
 */
@property (nonatomic, strong) UILabel *userNameL;


/**
 平台币可用余额
 */
@property (nonatomic, strong) UILabel *pingtaiL;

/**
 余额
 */
@property (nonatomic, strong) UILabel *restMoney;
@end

@implementation QLMineTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addTopSubviews];
    }
    return self;
}

/** top's subviews*/
- (void)addTopSubviews
{
    self.bgImageV = [[UIImageView alloc] init];
    [self addSubview:self.bgImageV];
    self.bgImageV.layer.cornerRadius = 5 *kScale;
    self.bgImageV.backgroundColor = [UIColor blackColor];
    
    self.headImageV = [[UIImageView alloc] init];
    [self addSubview:self.headImageV];
    self.headImageV.image = [UIImage imageNamed:@"mine_headImage"];
    
    
    self.userNameL = [[UILabel alloc] init];
    [self addSubview:self.userNameL];
    self.userNameL.text = @"亲爱的小芸芸";
    
    self.pingtaiL = [[UILabel alloc] init];
    [self addSubview:self.pingtaiL];
    self.pingtaiL.text = @"平台币可用余额";
    
    self.restMoney = [[UILabel alloc] init];
    [self addSubview:self.restMoney];
    self.restMoney.text = @"0.00";
    
    for (UILabel *lab in self.subviews) {
        if ([lab isKindOfClass:[UILabel class]]) {
            lab.textColor = [UIColor whiteColor];
            lab.textAlignment = 1;
            lab.font = kFont(15);
        }
    }
}
- (void)layoutSubviews
{
    self.bgImageV.frame = self.frame;
    
    self.headImageV.frame = CGRectMake(0, 25 *kScale, 70 *kScale, 70 *kScale);
    self.headImageV.centerX = self.center.x;
    self.headImageV.clipsToBounds = YES;
    self.headImageV.layer.cornerRadius = self.headImageV.bounds.size.width/2.0;
    
    self.userNameL.frame = CGRectMake(0, CGRectGetMaxY(self.headImageV.frame) + 5, kScreenWidth *0.5, 30 *kScale);
    self.userNameL.centerX = self.center.x;
    
    self.pingtaiL.frame = CGRectMake(0, CGRectGetMaxY(self.userNameL.frame) +5, kScreenWidth *0.5, 30 *kScale);
    self.pingtaiL.centerX = self.center.x;
    
    self.restMoney.frame = CGRectMake(0, CGRectGetMaxY(self.pingtaiL.frame), kScreenWidth *0.6, 30 *kScale);
    self.restMoney.centerX = self.center.x;
}

@end
