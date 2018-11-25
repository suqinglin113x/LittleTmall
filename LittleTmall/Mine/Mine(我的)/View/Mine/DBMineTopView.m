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
    self.bgImageV.layer.cornerRadius = 5 *kScale;
    self.bgImageV.backgroundColor = [UIColor blackColor];
    
    self.headImageV = [[UIImageView alloc] init];
    [self addSubview:self.headImageV];
    
    
    self.userNameL = [[UILabel alloc] init];
    [self addSubview:self.userNameL];
    
    self.pingtaiL = [[UILabel alloc] init];
    [self addSubview:self.pingtaiL];
    self.restCoinL = [[UILabel alloc] init];
    [self addSubview:self.restCoinL];
    
    for (UILabel *lab in self.subviews) {
        if ([lab isKindOfClass:[UILabel class]]) {
            lab.textColor = [UIColor whiteColor];
            lab.textAlignment = 1;
            lab.font = kFont(15);
        }
    }
    
    if([BaseUserTool getToken]){
        self.headImageV.image = [UIImage imageNamed:@"mine_headImage"];
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
    self.bgImageV.frame = self.frame;
    
    self.headImageV.frame = CGRectMake(0, 25 *kScale, 70 *kScale, 70 *kScale);
    self.headImageV.centerX = self.center.x;
    self.headImageV.clipsToBounds = YES;
    self.headImageV.layer.cornerRadius = self.headImageV.bounds.size.width/2.0;
    
    self.userNameL.frame = CGRectMake(0, CGRectGetMaxY(self.headImageV.frame) + 5, kScreenWidth *0.5, 30 *kScale);
    self.userNameL.centerX = self.center.x;
    
    self.pingtaiL.frame = CGRectMake(0, CGRectGetMaxY(self.userNameL.frame) +5, kScreenWidth *0.5, 30 *kScale);
    self.pingtaiL.centerX = self.center.x;
    
    self.restCoinL.frame = CGRectMake(0, CGRectGetMaxY(self.pingtaiL.frame), kScreenWidth *0.6, 30 *kScale);
    self.restCoinL.centerX = self.center.x;
}

- (void)setCoinStr:(NSString *)coinStr
{
    _coinStr = coinStr;
    self.restCoinL.text = [NSString stringWithFormat:@"%.2f", coinStr.floatValue];
}
@end
