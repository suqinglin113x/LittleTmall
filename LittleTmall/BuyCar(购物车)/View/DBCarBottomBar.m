//
//  DBCarBottomBar.m
//  LittleTmall
//
//  Created by Adam on 2018/11/19.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBCarBottomBar.h"

@interface DBCarBottomBar ()

@end
@implementation DBCarBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addBarSubviews];
    }
    
    return self;
}

- (void)addBarSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    // 勾
    UIButton *tickImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:tickImgBtn];
    self.tickImgBtn = tickImgBtn;
    [tickImgBtn setImage:[UIImage imageNamed:@"CellButton"] forState:UIControlStateNormal];
    [tickImgBtn setImage:[UIImage imageNamed:@"CellButtonSelected"] forState:UIControlStateSelected];
    [tickImgBtn addTarget:self action:@selector(chooseAll:) forControlEvents:UIControlEventTouchUpInside];
    // 全选
    UIButton *tickAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:tickAllBtn];
    self.tickAllBtn = tickAllBtn;
    tickAllBtn.titleLabel.font = kFont(13);
    [tickAllBtn setTitle:@"全选(0)" forState:UIControlStateNormal];
    [tickAllBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [tickAllBtn addTarget:self action:@selector(chooseAll:) forControlEvents:UIControlEventTouchUpInside];
   
    // 总钱
    UILabel *allMoneyL = [[UILabel alloc] init];
    [self addSubview:allMoneyL];
    self.allMoneyL = allMoneyL;
    allMoneyL.text = @"¥0.00";
    allMoneyL.textAlignment = 0;
    allMoneyL.textColor = kMainColor;
    allMoneyL.font = kFont(14);
    
    // 编辑
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:editBtn];
    self.editBtn = editBtn;
    editBtn.titleLabel.font = kFont(12);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 去结算
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buyBtn];
    self.buyBtn = buyBtn;
    buyBtn.titleLabel.font = kFont(14);
    buyBtn.layer.cornerRadius = 4*kScale;
    [buyBtn az_setGradientBackgroundWithColors:@[kMainBeginColor, kMainEndColor] locations:nil startPoint:CGPointMake(0,0) endPoint:CGPointMake(1, 0)];
    [buyBtn setTitle:@"去结算" forState:UIControlStateNormal];
//    [buyBtn setTitle:@"删除所选" forState:UIControlStateSelected];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)layoutSubviews
{
    CGFloat subviewsH = self.height;
    
    self.tickImgBtn.frame = CGRectMake(10 *kScale, 0, 15 *kScale, 15 *kScale);
    self.tickImgBtn.centerY = subviewsH *0.5;
    self.tickImgBtn.layer.cornerRadius = self.tickImgBtn.width *0.5;
    
    self.tickAllBtn.frame = CGRectMake(self.tickImgBtn.right, 0, 80 *kScale, subviewsH);
    self.tickAllBtn.centerY = subviewsH *0.5;
    
    self.allMoneyL.frame = CGRectMake(self.tickAllBtn.right, 0, 150 *kScale, subviewsH);
    self.allMoneyL.centerY = subviewsH *0.5;
    
    CGFloat buyBtnW = 80 *kScale;
    self.buyBtn.frame = CGRectMake(kScreenWidth - buyBtnW, 0, buyBtnW, subviewsH);
    self.buyBtn.centerY = self.height *0.5;
    
    CGFloat editBtnW = 30 *kScale;
    self.editBtn.frame = CGRectMake(self.buyBtn.left - 5*kScale - editBtnW, 0, editBtnW, subviewsH);
    self.editBtn.centerY = subviewsH *0.5;
}

#pragma mark -- action --
- (void)chooseAll:(UIButton *)btn
{
    btn.selected = self.tickImgBtn.selected;
    btn.selected = !btn.selected;
    self.tickAllBtn.selected = self.tickImgBtn.selected = btn.selected;
    if (btn.selected) {
       
    }
    // 计算总金额
    
    // 全选操作
    if (self.chooseAllBlock) {
        self.chooseAllBlock(btn.selected);
    }
}

- (void)editBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.editBtn.selected = btn.selected;
    self.buyBtn.selected = btn.selected;
    if (btn.selected) {
        [self.buyBtn setTitle:@"删除所选" forState:UIControlStateNormal];
        self.allMoneyL.hidden = YES;
        [self.tickAllBtn setTitle:@"全选(0)" forState:UIControlStateNormal];
    } else {
        [self.buyBtn setTitle:@"去结算" forState:UIControlStateNormal];
        self.allMoneyL.hidden = NO;
    }
    if (self.editBlock) {
        self.editBlock(btn.selected);
    }
    DBLog(@"编辑、完成商品");
}

/** 删除or结算*/
- (void)buyBtnClick:(UIButton *)btn
{
    if (self.buyOrDelBtnBlock) {
        self.buyOrDelBtnBlock(btn.selected);
    }
    
}

#pragma mark -- setting --
- (void)setResultDelArr:(NSArray *)resultDelArr
{
    _resultDelArr = resultDelArr;
    [self.tickAllBtn setTitle:[NSString stringWithFormat:@"全选(%lu)", (unsigned long)resultDelArr.count] forState:UIControlStateNormal];
}

- (void)setCartModel:(DBCartModel *)cartModel
{
    if (cartModel == nil) {
        self.tickImgBtn.selected = self.tickAllBtn.selected = NO;
        [self.tickAllBtn setTitle:@"全选(0)" forState:UIControlStateNormal];
        self.allMoneyL.text = @"¥0";
        return;
    }
    
    _cartModel = cartModel;
    if(cartModel.cartTotalModel.goodsCount.intValue == cartModel.cartTotalModel.checkedGoodsCount.intValue) {
        self.tickImgBtn.selected = YES;
    } else {
        self.tickImgBtn.selected = NO;
        
    }
    [self.tickAllBtn setTitle:[NSString stringWithFormat:@"全选(%@)", cartModel.cartTotalModel.checkedGoodsCount] forState:UIControlStateNormal];
    self.allMoneyL.text = [NSString stringWithFormat:@"¥%.2f", cartModel.cartTotalModel.checkedGoodsAmount.floatValue];
    
}
@end
