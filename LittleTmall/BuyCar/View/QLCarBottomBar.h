//
//  QLCarBottomBar.h
//  LittleTmall
//
//  Created by Adam on 2018/11/19.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLCarBottomBar : UIView

@property (nonatomic, copy) void(^chooseAllBlock)(BOOL isSelected);

@property (nonatomic, copy) NSArray *dataArr;
@end
