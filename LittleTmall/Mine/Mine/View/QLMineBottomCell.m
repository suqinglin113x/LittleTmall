//
//  QLMineBottomCell.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLMineBottomCell.h"

@interface QLMineBottomCell()

@property (nonatomic, strong) UIButton *itemBtn;

@end
@implementation QLMineBottomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addItemSubviews];
    }
    return self;
}

- (void)addItemSubviews
{
    self.itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.itemBtn];
    [self.itemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.itemBtn.titleLabel.font = kFont(15);
    self.itemBtn.backgroundColor = [UIColor clearColor];
    self.itemBtn.enabled = NO;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.itemBtn.frame = self.contentView.frame;
    // 必须加载contenView上
    self.itemBtn.center = self.contentView.center;
    [self.itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(0 *kScale, -self.itemBtn.imageView.width, -self.itemBtn.imageView.height -15, 0)];
    [self.itemBtn setImageEdgeInsets:UIEdgeInsetsMake(-self.itemBtn.titleLabel.height - 15, 0, 0, -self.itemBtn.titleLabel.width)];
}

- (void)setTitleStr:(NSString *)titleStr
{
    [self.itemBtn setTitle:titleStr forState:UIControlStateNormal];
    [self.itemBtn setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
}
@end
