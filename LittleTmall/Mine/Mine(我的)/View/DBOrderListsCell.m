//
//  DBOrderListsCell.m
//  LittleTmall
//
//  Created by Adam on 2018/11/25.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBOrderListsCell.h"

@interface DBOrderListsCell ()
@property (nonatomic, weak) UIView *lineTopView;
@property (nonatomic, weak) UILabel *orderTitleL;
@property (nonatomic, weak) UILabel *orderNumL;
@property (nonatomic, weak) UILabel *orderStatusL;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UILabel *orderPriceL;
@property (nonatomic, weak) UIButton *payPriceBtn;
@end
@implementation DBOrderListsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createOrderSubviews];
    }
    return self;
}

- (void)createOrderSubviews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *lineTopView = [[UIView alloc] init];
    self.lineTopView = lineTopView;
    lineTopView.backgroundColor = kBgColor;
    [self.contentView addSubview:lineTopView];
    
    UILabel *orderTitleL = [[UILabel alloc] init];
    self.orderTitleL = orderTitleL;
    orderTitleL.textAlignment = 0;
    orderTitleL.textColor = kTextColor;
    orderTitleL.font = kFont(13);
    orderTitleL.text = @"订单编号:";
    [self.contentView addSubview:orderTitleL];
    
    UILabel *orderNumL = [[UILabel alloc] init];
    self.orderNumL = orderNumL;
    orderNumL.textAlignment = 0;
    orderNumL.textColor = kTextColor;
    orderNumL.font = kFont(13);
    orderNumL.text = @"xxx-xxx:";
    [self.contentView addSubview:orderNumL];
    
    UILabel *orderStatusL = [[UILabel alloc] init];
    self.orderStatusL = orderStatusL;
    orderStatusL.textAlignment = 2;
    orderStatusL.textColor = kMainColor;
    orderStatusL.font = kFont(13);
    orderStatusL.text = @"未付款";
    [self.contentView addSubview:orderStatusL];
    
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = kBgColor;
    [self.contentView addSubview:lineView];
    
    UILabel *orderPriceL = [[UILabel alloc] init];
    self.orderPriceL = orderPriceL;
    orderPriceL.textAlignment = 0;
    orderPriceL.textColor = kTextColor;
    orderPriceL.font = kFont(13);
    orderPriceL.text = @"实付: ";
    [self.contentView addSubview:orderPriceL];
    
    UIButton *payPriceBtn = [[UIButton alloc] init];
    self.payPriceBtn = payPriceBtn;
    [payPriceBtn setTitle:@"去付款" forState:UIControlStateNormal];
    payPriceBtn.backgroundColor = kMainColor;
    payPriceBtn.layer.cornerRadius = 5;
    [payPriceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payPriceBtn.titleLabel setFont:kFont(14)];
    [payPriceBtn addTarget:self action:@selector(toContinuePayMoney) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:payPriceBtn];
}

- (void)layoutSubviews
{
    CGFloat margin = 10 *kScale;
    self.lineTopView.frame = CGRectMake(0, 0, kScreenWidth, 10 *kScale);
    self.orderTitleL.frame = CGRectMake(margin, self.lineTopView.bottom,60 *kScale, 30 *kScale);
    self.orderNumL.frame = CGRectMake(self.orderTitleL.right, self.orderTitleL.top, 240 *kScale, self.orderTitleL.height);
    self.orderStatusL.frame = CGRectMake(kScreenWidth - margin - 60 *kScale, self.orderTitleL.top, 60 *kScale, self.orderTitleL.height);
    self.lineView.frame = CGRectMake(margin, self.orderTitleL.bottom+1*kScale, kScreenWidth, 1*kScale);
    self.orderPriceL.frame = CGRectMake(margin, self.lineView.bottom, 200 *kScale, 50 *kScale);
    self.payPriceBtn.frame = CGRectMake(kScreenWidth - margin - 60 *kScale, 0, 60 *kScale, 30 *kScale);
    self.payPriceBtn.centerY = self.orderPriceL.centerY;
    
}

- (void)setModel:(DBOrderListModel *)model
{
    _model = model;
    self.orderNumL.text = model.order_sn;
    self.orderStatusL.text = model.order_status_text;
    self.orderPriceL.text = [NSString stringWithFormat:@"实付:  ¥%.2f", model.actual_price.floatValue];
}

- (void)toContinuePayMoney
{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
