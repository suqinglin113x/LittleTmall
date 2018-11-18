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
    self.itemBtn.backgroundColor = [UIColor redColor];
    
    
}

- (void)layoutSubviews
{
    self.itemBtn.frame = CGRectMake(0, 0, self.width *0.5, self.width *0.7);
    // 必须加载contenView上
    self.itemBtn.center = self.contentView.center;
}

- (void)setTitleStr:(NSString *)titleStr
{
    [self.itemBtn setTitle:titleStr forState:UIControlStateNormal];
}
@end
