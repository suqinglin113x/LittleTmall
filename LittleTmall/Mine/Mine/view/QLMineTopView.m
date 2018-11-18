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

@property (nonatomic, strong) UIImageView *headImageV;

@property (nonatomic, strong) UILabel *userNameL;

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
    self.bgImageV.backgroundColor = kBgColor;
    
    self.headImageV = [[UIImageView alloc] init];
    [self addSubview:self.headImageV];
    self.headImageV.image = [UIImage imageNamed:@"mine_headImage"];
    
    
    self.userNameL = [[UILabel alloc] init];
    [self addSubview:self.userNameL];
    self.userNameL.text = @"亲爱的小芸芸";
    self.userNameL.textAlignment = 1;
    self.userNameL.font = kFont(15);
    
}
- (void)layoutSubviews
{
    self.bgImageV.frame = self.frame;
    
    self.headImageV.bounds = CGRectMake(0, 0, 70, 70);
    self.headImageV.center = CGPointMake(self.center.x, self.center.y - 20);
    self.headImageV.layer.cornerRadius = self.headImageV.bounds.size.width/2.0;
    self.headImageV.clipsToBounds = YES;
    
    self.userNameL.frame = CGRectMake(0, CGRectGetMaxY(self.headImageV.frame) + 5, kScreenWidth *0.5, 30);
    self.userNameL.centerX = self.center.x;
}

@end
