//
//  DBMineTopView.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBMineTopView.h"

@interface DBMineTopView()

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

@property (nonatomic, strong) UIView *moneyView;
/**
 平台币可用余额
 */
@property (nonatomic, strong) UILabel *pingtaiL;

/**
 余额
 */
@property (nonatomic, strong) UILabel *restCoinL;
@end

@implementation DBMineTopView

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
    [self.bgImageV az_setGradientBackgroundWithColors:@[kMainBeginColor, kMainEndColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    self.headImageV = [[UIImageView alloc] init];
    [self addSubview:self.headImageV];
    
    self.userNameL = [[UILabel alloc] init];
    self.userNameL.textColor = [UIColor whiteColor];
    self.userNameL.textAlignment = 1;
    self.userNameL.font = kFont(17);
    [self addSubview:self.userNameL];
    
    // -----**************-------
    self.moneyView = [[UIView alloc] init];
    self.moneyView.backgroundColor = UIColorFromRGBA(0, 0, 0, 0.1);
    [self addSubview:self.moneyView];
    
    self.pingtaiL = [[UILabel alloc] init];
    self.pingtaiL.textColor = [UIColor whiteColor];
    self.pingtaiL.textAlignment = 0;
    self.pingtaiL.font = kFont(15);
    [self.moneyView addSubview:self.pingtaiL];
    
    self.restCoinL = [[UILabel alloc] init];
    self.restCoinL.textColor = [UIColor whiteColor];
    self.restCoinL.textAlignment = 2;
    self.restCoinL.font = kFont(15);
    [self.moneyView addSubview:self.restCoinL];
    
    // -----**************-------
    if([BaseUserTool getToken]){
        self.headImageV.image = [UIImage imageNamed:@"logo"];
        self.userNameL.text = @"斗宝商城";
        self.pingtaiL.text = @"平台币可用余额";
        self.restCoinL.text = @"0.00";
    } else {
        self.headImageV.image = [UIImage imageNamed:@""];
        self.userNameL.text = @"hi，请登录";
        self.pingtaiL.hidden = self.restCoinL.hidden = YES;
    }
}
- (void)layoutSubviews
{
    CGFloat margin = 15 *kScale;
    self.bgImageV.frame = self.frame;
    
    self.headImageV.frame = CGRectMake(0, 50 *kScale, 70 *kScale, 70 *kScale);
    self.headImageV.centerX = self.center.x;
    self.headImageV.clipsToBounds = YES;
    self.headImageV.layer.cornerRadius = self.headImageV.bounds.size.width/2.0;
    
    self.userNameL.frame = CGRectMake(0, CGRectGetMaxY(self.headImageV.frame) + 5, kScreenWidth *0.5, 30 *kScale);
    self.userNameL.centerX = self.center.x;
    
    self.moneyView.frame = CGRectMake(0, self.height - 49 *kScale, self.width, 49 *kScale);
    
    self.pingtaiL.frame = CGRectMake(margin, 0, self.width *0.5 -margin, self.moneyView.height);
    
    self.restCoinL.frame = CGRectMake(self.width *0.5, 0, self.width *0.5 - margin, self.moneyView.height);
}

- (void)setCoinStr:(NSString *)coinStr
{
    _coinStr = coinStr;
    self.restCoinL.text = [NSString stringWithFormat:@"%.2f", coinStr.floatValue];
}
@end
