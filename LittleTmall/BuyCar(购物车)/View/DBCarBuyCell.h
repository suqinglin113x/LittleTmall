//
//  DBCarBuyCell.h
//  LittleTmall
//
//  Created by Adam on 2018/11/19.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBCarBuyCell : UITableViewCell

@property (nonatomic, strong) UIImageView *productImgV;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *priceL;
@property (nonatomic, strong) UILabel *amountL;
@property (nonatomic, strong) UILabel *yixuanzeL;

// 数量选择器
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, strong) UILabel *calculateL;

// model
@property (nonatomic, strong) DBCarListModel *model;

/**
 cell编辑状态处理

 @param isEdting 编辑状态
 */
- (void)cellEditingStatus:(BOOL)isEdting;
@end
