//
//  DBVerifyOrderHeader.m
//  LittleTmall
//
//  Created by Adam on 2018/11/27.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBVerifyOrderHeader.h"

@interface DBVerifyOrderHeader ()
@property (nonatomic, strong) UILabel * addressView;
@property (nonatomic, strong) UILabel *userNameL;
@property (nonatomic, strong) UILabel *phoneNumL;
@property (nonatomic, strong) UILabel *addressL;
@property (nonatomic, strong) UILabel *tagL;
@property (nonatomic, strong) UIImageView *arrowIV;

@property (nonatomic, strong) UIView * couponView;
@property (nonatomic, strong) UILabel *couponChooseL;
@property (nonatomic, strong) UILabel *couponDetilL;
@property (nonatomic, strong) UIImageView *arrowIV2;

@property (nonatomic, strong) UIView *infoView;
// 存放商品信息子label的集合
@property (nonatomic, strong) NSMutableArray *infoLArr;
@end

@implementation DBVerifyOrderHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addOrderSubviews];
        _infoLArr = [NSMutableArray array];
    }
    return self;
}

- (void)addOrderSubviews
{
    // **** 地址栏 *****
    UILabel *addressView = [[UILabel alloc] init];
    self.addressView = addressView;
    self.addressView.font = kFont(13);
    self.addressView.textAlignment = 1;
    self.addressView.textColor = kTextColor;
    [self addSubview:addressView];
    addressView.backgroundColor = [UIColor whiteColor];
    
    self.userNameL = [[UILabel alloc] init];
    [addressView addSubview:self.userNameL];
    self.userNameL.font = kFont(15);
    self.userNameL.textAlignment = 0;
    self.userNameL.textColor = kTextColor;
    self.userNameL.text = @"斗宝宝";
    
    self.phoneNumL = [[UILabel alloc] init];
    [addressView addSubview:self.phoneNumL];
    self.phoneNumL.font = kFont(15);
    self.phoneNumL.textAlignment = 0;
    self.phoneNumL.textColor = kTextColor;
    self.phoneNumL.text = @"132*****65";
    
    self.addressL = [[UILabel alloc] init];
    [addressView addSubview:self.addressL];
    self.addressL.font = kFont(14);
    self.addressL.textAlignment = 0;
    self.addressL.numberOfLines = 3;
    self.addressL.textColor = kTextColor;
    self.addressL.text = @"xxx xxx xxx xxx";
    
    self.arrowIV = [[UIImageView alloc] init];
    [addressView addSubview:self.arrowIV];
    [self.arrowIV setImage:[UIImage imageNamed:@"back"]];
    self.arrowIV.transform = CGAffineTransformMakeRotation(M_PI);
    
    UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressLClick:)];
    addressView.userInteractionEnabled = YES;
    [addressView addGestureRecognizer:addressTap];
    
    // **** 优惠券 *****
    UIView *couponView = [[UIView alloc] init];
    [self addSubview:couponView];
    self.couponView = couponView;
    couponView.backgroundColor = [UIColor whiteColor];
    
    self.couponChooseL = [[UILabel alloc] init];
    [couponView addSubview:self.couponChooseL];
    self.couponChooseL.font = kFont(15);
    self.couponChooseL.textAlignment = 0;
    self.couponChooseL.textColor = kTextColor;
    self.couponChooseL.text = @"请选择优惠券";
    
    self.couponDetilL = [[UILabel alloc] init];
    [couponView addSubview:self.couponDetilL];
    self.couponDetilL.font = kFont(15);
    self.couponDetilL.textAlignment = 2;
    self.couponDetilL.textColor = kTextColor;
    self.couponDetilL.text = @"平台抵扣券";
    
    self.arrowIV2 = [[UIImageView alloc] init];
    [couponView addSubview:self.arrowIV2];
    [self.arrowIV2 setImage:[UIImage imageNamed:@"back"]];
    self.arrowIV2.transform = CGAffineTransformMakeRotation(M_PI);
    
    UITapGestureRecognizer *couponTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponLClick:)];
    [couponView addGestureRecognizer:couponTap];
    
    // **** 商品详情 *****
    UIView *infoView = [[UIView alloc] init];
    [self addSubview:infoView];
    self.infoView = infoView;
    self.infoView.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10 *kScale;
    // **** 地址栏 *****
    self.addressView.frame = CGRectMake(0, 0, kScreenWidth, 70*kScale);
    self.userNameL.frame = CGRectMake(margin, margin *0.6, 60 *kScale, 30 *kScale);
    self.phoneNumL.frame = CGRectMake(self.userNameL.right, self.userNameL.top-3*kScale, 150 *kScale, 30 *kScale);
    self.addressL.frame = CGRectMake(self.userNameL.right, self.phoneNumL.bottom- margin, 250 *kScale, 50 *kScale);
    self.arrowIV.frame = CGRectMake(kScreenWidth - 25 *kScale, 0, 15*kScale, 15 *kScale);
    self.arrowIV.centerY = self.addressView.height/2.0;
    
     // **** 优惠券 *****
    self.couponView.frame = CGRectMake(0, self.addressView.bottom + 10 *kScale, kScreenWidth, 50 *kScale);
    self.couponChooseL.frame = CGRectMake(margin, 0, 120 *kScale, self.couponView.height);
    self.couponDetilL.frame = CGRectMake(kScreenWidth - 130 *kScale, 0, 100 *kScale, self.couponView.height);
    self.arrowIV2.frame = CGRectMake(kScreenWidth - 25 *kScale, 0, 15*kScale, 15 *kScale);
    self.arrowIV2.centerY = self.couponView.height/2.0;
    
     // **** 商品详情 *****
    self.infoView.frame = CGRectMake(0, self.couponView.bottom + 10 *kScale, kScreenWidth, 150 *kScale);
    NSArray *names = @[@"商品合计", @"运费", @"优惠券"];
    CGFloat height = 50 *kScale;
    for (NSInteger i = 0; i< names.count ; i ++) {
        UILabel *nameL = [[UILabel alloc] init];
        nameL.text = names[i];
        nameL.textAlignment = 0;
        nameL.textColor = kTextColor;
        nameL.font = kFont(14);
        nameL.frame = CGRectMake(margin, height *i, 120 *kScale, height);
        UILabel *infoDetailL = [[UILabel alloc] init];
        [_infoLArr addObject:infoDetailL];
        infoDetailL.textAlignment = 2;
        infoDetailL.textColor = kTextColor;
        infoDetailL.font = kFont(14);
        infoDetailL.frame = CGRectMake(kScreenWidth - 95*kScale, height *i, 80 *kScale, height);
        [self.infoView addSubview:nameL];
        [self.infoView addSubview:infoDetailL];
        
    }
}

- (void)setOrderModel:(DBVerifyOrderModel *)orderModel
{
    NSString *userName = orderModel.checkedAddressModel.userName;
    NSString *telPhone = orderModel.checkedAddressModel.telNumber;
    NSString *addressStr = orderModel.checkedAddressModel.full_address;
    if (userName && telPhone && addressStr) {
        self.userNameL.text = userName;
        self.phoneNumL.text = telPhone;
        self.addressL.text = addressStr;
    } else {
        self.userNameL.hidden = self.phoneNumL.hidden =self.addressL.hidden = YES;
       self.addressView.text = @"还没有收货地址，快去添加地址";
    }
    NSString *actualPrice = [NSString stringWithFormat:@"¥%@", orderModel.actualPrice];
    NSString *freightPrice = [NSString stringWithFormat:@"¥%@", orderModel.freightPrice];
    NSString *couponPrice = [NSString stringWithFormat:@"-¥%@", orderModel.couponPrice];
    NSArray *temArr = @[actualPrice, freightPrice, couponPrice];
    [_infoLArr enumerateObjectsUsingBlock:^(__kindof UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = temArr[idx];
    }];
}

#pragma mark -- action --

- (void)addressLClick:(UITapGestureRecognizer *)tap
{
    DBLog(@"选择地址");
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseAddress)]) {
        [self.delegate chooseAddress];
    }
}
- (void)couponLClick:(UITapGestureRecognizer *)tap
{
    DBLog(@"优惠券点击");
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseCoupon)]) {
        [self.delegate chooseCoupon];
    }
}

@end
