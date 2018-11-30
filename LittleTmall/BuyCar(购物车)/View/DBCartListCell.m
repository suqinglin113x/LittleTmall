//
//  DBCartListCell.m
//  LittleTmall
//
//  Created by Adam on 2018/11/19.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBCartListCell.h"

@interface DBCartListCell()
@property (nonatomic, strong) UIView *amountPickView;
@property (nonatomic, strong) UIButton *itemCellBtn;
@end
@implementation DBCartListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addCarCellSubviews];
    }
    return self;
}

- (void)addCarCellSubviews
{
    self.productImgV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.productImgV];
    
    // 商品名称
    self.productName = [[UILabel alloc] init];
    [self.contentView addSubview:self.productName];
    self.productName.font = kFont(13);
    self.productName.textAlignment = 0;
    self.productName.numberOfLines = 2;
    self.productName.textColor = kTextColor;
    
    // 价格
    self.priceL = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceL];
    self.priceL.font = kFont(15);
    self.priceL.textAlignment = 0;
    self.priceL.textColor = kMainColor;
    
    // 购买数量
    self.amountL = [[UILabel alloc] init];
    [self.contentView addSubview:self.amountL];
    self.amountL.font = kFont(15);
    self.amountL.textAlignment = 2;
    self.amountL.textColor = kTextColor;
    
    // 已选择
    self.yixuanzeL = [[UILabel alloc] init];
    [self.contentView addSubview:self.yixuanzeL];
    self.yixuanzeL.hidden = YES;
    self.yixuanzeL.text = @"已选择:";
    self.yixuanzeL.font = kFont(14);
    self.yixuanzeL.textAlignment = 2;
    self.yixuanzeL.textColor = kTextColor;
    
    // itemCellBtn
    self.itemCellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.itemCellBtn];
    [self.itemCellBtn addTarget:self action:@selector(itemCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.itemCellBtn.backgroundColor = [UIColor clearColor];
    
    //数量选择器
    self.amountPickView = [[UIView alloc] init];
    [self.contentView addSubview:self.amountPickView];
    self.amountPickView.hidden = YES;
    self.amountPickView.layer.borderWidth = 0.6;
    self.amountPickView.layer.borderColor = kBgColor.CGColor;
    
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.amountPickView addSubview:self.minusBtn];
    [self.minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.minusBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    self.minusBtn.titleLabel.font = kFont(17);
    
    self.calculateL = [[UILabel alloc] init];
    [self.amountPickView addSubview:self.calculateL];
    self.calculateL.font = kFont(15);
    self.calculateL.textAlignment = 1;
    self.calculateL.text = @"1";
    self.calculateL.textColor = kTextColor;
    self.calculateL.layer.borderWidth = 0.6;
    self.calculateL.layer.borderColor = kBgColor.CGColor;
    
    self.plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.amountPickView addSubview:self.plusBtn];
    [self.plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.plusBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.plusBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    self.plusBtn.titleLabel.font = kFont(17);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.productImgV.frame = CGRectMake(10 *kScale, 10 *kScale, 60*kScale, 60*kScale);
    self.productName.frame = CGRectMake(self.productImgV.right +10*kScale, 0, 190 *kScale, 50*kScale);
    self.priceL.frame = CGRectMake(self.productImgV.right + 10*kScale, self.contentView.bottom - 40*kScale, 100 *kScale, 30*kScale);
    self.amountL.frame = CGRectMake(self.contentView.width - 60*kScale, self.productImgV.top, 50*kScale, 30*kScale);
    self.yixuanzeL.frame = self.amountL.frame;
    
    self.itemCellBtn.frame = CGRectMake(5 *kScale, 0, self.contentView.width, self.contentView.height);
    
    // 数量选择器
    self.amountPickView.frame = CGRectMake(self.contentView.width - 120*kScale, self.contentView.bottom - 40*kScale, 110*kScale, 30*kScale);
    CGFloat minusBtnW = self.amountPickView.width/3.0;
    CGFloat minusBtnH = self.amountPickView.height;
    self.minusBtn.frame = CGRectMake(0, 0, minusBtnW, minusBtnH);
    self.calculateL.frame = CGRectMake(minusBtnW, 0, minusBtnW, minusBtnH);
    self.plusBtn.frame = CGRectMake(minusBtnW *2, 0, minusBtnW, minusBtnH);
    
    // ...
    [self dealCellEditingStatus];
}

- (void)setCarListModel:(DBCarListModel *)carListModel
{
    _carListModel = carListModel;
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:carListModel.list_pic_url] placeholderImage:[UIImage imageNamed:@"购物车"]];
    self.productName.text = carListModel.goods_name;
    self.priceL.text = [NSString stringWithFormat:@"¥%.2f", carListModel.market_price.floatValue];
    self.amountL.text = [NSString stringWithFormat:@"x%@", carListModel.number];
}

#pragma mark -- action --
- (void)minusBtnClick:(UIButton *)btn
{
    int num = [self.calculateL.text intValue];
    if (num > 1) {
        num --;
        self.calculateL.text = [NSString stringWithFormat:@"%d", num];
    } else {
        self.calculateL.text = @"1";
    }
//    self.amountL.text = self.calculateL.text;
    
    [self updateProductNumData];
}
- (void)plusBtnClick:(UIButton *)btn
{
    int num = [self.calculateL.text intValue];
    if (num < 15) {
        num ++;
        self.calculateL.text = [NSString stringWithFormat:@"%d", num];
    } else {
        self.calculateL.text = @"15";
    }
//    self.amountL.text = self.calculateL.text;
    
    [self updateProductNumData];
}

/** 更新商品数量*/
- (void)updateProductNumData{
    NSDictionary *dict = @{@"productId":self.carListModel.product_id,
                           @"goodsId":self.carListModel.goods_id,
                           @"id":self.carListModel.id,
                           @"number":self.calculateL.text
                           };
    [BaseNetTool CarNumPickParams:dict block:^(DBCartModel *model, NSError *error) {
        
    }];
}
- (void)itemCellBtnClick:(UIButton *)btn
{
    DBLog(@"跳到对应商品详情页");
    if (self.itemCellBtnBlock) {
        self.itemCellBtnBlock();
    }
}


- (void)cellEditingStatus:(BOOL)isEdting
{
    if (isEdting) {
        self.priceL.hidden = YES;
        self.amountL.hidden = YES;
//        self.productName.hidden = YES;
        self.yixuanzeL.hidden = NO;
        self.amountPickView.hidden = NO;
        self.calculateL.text = self.carListModel.number;
    } else {
        self.priceL.hidden = NO;
        self.amountL.hidden = NO;
//        self.productName.hidden = NO;
        self.yixuanzeL.hidden = YES;
        self.amountPickView.hidden = YES;
    }
    [self layoutIfNeeded];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self dealCellEditingStatus];
}


/**
 处理cell编辑状态下的 选中勾
 */
- (void)dealCellEditingStatus
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews)
            {
                if ([view isKindOfClass: [UIImageView class]]) {
                    UIImageView *image=(UIImageView *)view;
                    if (self.selected) {
                        image.image=[UIImage imageNamed:@"CellButtonSelected"];
                    }
                    else
                    {
                        image.image=[UIImage imageNamed:@"CellButton"];
                    }
                }
            }
        }
    }
}

@end
