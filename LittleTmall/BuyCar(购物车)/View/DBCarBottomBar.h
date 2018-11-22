//
//  DBCarBottomBar.h
//  LittleTmall
//
//  Created by Adam on 2018/11/19.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBCarBottomBar : UIView

@property (nonatomic, weak) UIButton *tickImgBtn;

@property (nonatomic, weak) UIButton *tickAllBtn;

@property (nonatomic, weak) UILabel *allMoneyL;

@property (nonatomic, weak) UIButton *editBtn;

@property (nonatomic, weak) UIButton *buyBtn;


@property (nonatomic, copy) void(^chooseAllBlock)(BOOL isSelected);

@property (nonatomic, copy) void(^editBlock)(BOOL isSelected);

@property (nonatomic, copy) NSArray *dataArr;
@end
