//
//  QLMineBottomView.h
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLMineBottomView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *itemsArray;

- (CGFloat) getContentHeight;
@end

NS_ASSUME_NONNULL_END
