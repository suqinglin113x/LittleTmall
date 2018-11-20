//
//  QLCarBuyCell.m
//  LittleTmall
//
//  Created by Adam on 2018/11/19.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLCarBuyCell.h"

@interface QLCarBuyCell()
@property (nonatomic, strong) UIView *amountPickView;
@end
@implementation QLCarBuyCell


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
    self.productName.font = kFont(15);
    self.productName.textAlignment = 0;
    self.productName.textColor = [UIColor blackColor];
    
    // 价格
    self.priceL = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceL];
    self.priceL.font = kFont(15);
    self.priceL.textAlignment = 0;
    self.priceL.textColor = [UIColor blackColor];
    
    // 购买数量
    self.amountL = [[UILabel alloc] init];
    [self.contentView addSubview:self.amountL];
    self.amountL.font = kFont(15);
    self.amountL.textAlignment = 2;
    self.amountL.textColor = [UIColor blackColor];
    
    // 已选择
    self.yixuanzeL = [[UILabel alloc] init];
    [self.contentView addSubview:self.yixuanzeL];
    self.yixuanzeL.hidden = YES;
    self.yixuanzeL.text = @"已选择:";
    self.yixuanzeL.font = kFont(14);
    self.yixuanzeL.textAlignment = 2;
    self.yixuanzeL.textColor = [UIColor blackColor];
    
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
    [self.minusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.minusBtn.titleLabel.font = kFont(17);
    
    self.calculateL = [[UILabel alloc] init];
    [self.amountPickView addSubview:self.calculateL];
    self.calculateL.font = kFont(15);
    self.calculateL.textAlignment = 1;
    self.calculateL.text = @"1";
    self.calculateL.textColor = [UIColor blackColor];
    self.calculateL.layer.borderWidth = 0.6;
    self.calculateL.layer.borderColor = kBgColor.CGColor;
    
    self.plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.amountPickView addSubview:self.plusBtn];
    [self.plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.plusBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.plusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.plusBtn.titleLabel.font = kFont(17);
    
}

- (void)layoutSubviews
{
    self.productImgV.frame = CGRectMake(10, 10, 60, 60);
    self.productName.frame = CGRectMake(self.productImgV.right +10, self.productImgV.top, 200, 30);
    self.priceL.frame = CGRectMake(self.productImgV.right + 10, self.contentView.bottom - 40, 60, 30);
    self.amountL.frame = CGRectMake(self.contentView.width - 70, self.productImgV.top, 60, 30);
    self.yixuanzeL.frame = self.amountL.frame;
    
    // 数量选择器
    self.amountPickView.frame = CGRectMake(self.contentView.width - 120, self.contentView.bottom - 40, 110, 30);
    CGFloat minusBtnW = self.amountPickView.width/3.0;
    CGFloat minusBtnH = self.amountPickView.height;
    self.minusBtn.frame = CGRectMake(0, 0, minusBtnW, minusBtnH);
    self.calculateL.frame = CGRectMake(minusBtnW, 0, minusBtnW, minusBtnH);
    self.plusBtn.frame = CGRectMake(minusBtnW *2, 0, minusBtnW, minusBtnH);
    
    [self dealCellEditingStatus];
    [super layoutSubviews];
}

- (void)setProductStr:(NSString *)productStr
{
    self.productImgV.image = [UIImage imageNamed:@"mine_headImage"];
    self.productName.text = productStr;
    self.priceL.text = @"¥10";
    self.amountL.text = [NSString stringWithFormat:@"x%d", [self.calculateL.text intValue]];
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
    self.amountL.text = self.calculateL.text;
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
    self.amountL.text = self.calculateL.text;
}
- (void)refreshDatas
{
    
}
- (void)cellEditingStatus:(BOOL)isEdting
{
    if (isEdting) {
        self.priceL.hidden = YES;
        self.amountL.hidden = YES;
        self.yixuanzeL.hidden = NO;
        self.amountPickView.hidden = NO;
    } else {
        self.priceL.hidden = NO;
        self.amountL.hidden = NO;
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
