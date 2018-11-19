//
//  QLCarBottomBar.m
//  LittleTmall
//
//  Created by Adam on 2018/11/19.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLCarBottomBar.h"

@interface QLCarBottomBar ()
@property (nonatomic, weak) UIButton *tickImgBtn;

@property (nonatomic, weak) UIButton *tickAllBtn;

@property (nonatomic, weak) UILabel *allMoneyL;

@property (nonatomic, weak) UIButton *editBtn;

@property (nonatomic, weak) UIButton *buyBtn;
@end
@implementation QLCarBottomBar

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
    [tickImgBtn setImage:[UIImage imageNamed:@"circle_nosel"] forState:UIControlStateNormal];
    [tickImgBtn setImage:[UIImage imageNamed:@"circle_sel"] forState:UIControlStateSelected];
    [tickImgBtn addTarget:self action:@selector(chooseAll:) forControlEvents:UIControlEventTouchUpInside];
    // 全选
    UIButton *tickAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:tickAllBtn];
    self.tickAllBtn = tickAllBtn;
    tickAllBtn.titleLabel.font = kFont(13);
    [tickAllBtn setTitle:@"全选(0)" forState:UIControlStateNormal];
    [tickAllBtn setTitle:@"全选(100)" forState:UIControlStateSelected];
    [tickAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tickAllBtn addTarget:self action:@selector(chooseAll:) forControlEvents:UIControlEventTouchUpInside];
   
    // 总钱
    UILabel *allMoneyL = [[UILabel alloc] init];
    [self addSubview:allMoneyL];
    self.allMoneyL = allMoneyL;
    allMoneyL.text = @"¥100";
    allMoneyL.textAlignment = 0;
    allMoneyL.textColor = [UIColor blackColor];
    allMoneyL.font = kFont(14);
    
    // 编辑
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:editBtn];
    self.editBtn = editBtn;
    editBtn.titleLabel.font = kFont(13);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 去结算
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:buyBtn];
    self.buyBtn = buyBtn;
    buyBtn.titleLabel.font = kFont(13);
    buyBtn.backgroundColor = kMainColor;
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
    
    self.tickAllBtn.frame = CGRectMake(self.tickImgBtn.right - 5 *kScale, 0, 80 *kScale, subviewsH);
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
    btn.selected = !btn.selected;
    self.tickAllBtn.selected = self.tickImgBtn.selected = btn.selected;

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
    } else {
        [self.buyBtn setTitle:@"去结算" forState:UIControlStateNormal];
    }
    QLLog(@"编辑商品");
}

- (void)buyBtnClick:(UIButton *)btn
{
    if (self.buyBtn.selected) {
        
        QLLog(@"删除所选");
        // 去删除
        
    } else {
        QLLog(@"结算");
    }
    
}

#pragma mark -- setting --
- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
}
@end
