//
//  DBMineBottomView.h
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DBMineBottomViewDelegate <NSObject>
@required
- (void)bottomItemClick:(NSInteger)currentIndex;
@end
@interface DBMineBottomView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *itemsArray;

@property (nonatomic, weak) id <DBMineBottomViewDelegate> delegate;

- (CGFloat) getContentHeight;
@end

NS_ASSUME_NONNULL_END
