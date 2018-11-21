//
//  DBMineBottomView.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBMineBottomView.h"
#import "DBMineBottomCell.h"

#define linMargin 1 *kScale
#define topMargin 10 *kScale
#define itemW (kScreenWidth - linMargin *2) /3
#define itemH 93 *kScale

@interface DBMineBottomView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, copy) NSArray *temArr;

@end
@implementation DBMineBottomView

static NSString *const Mine_BottomCell = @"DBMineBottomCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addBottomSubviews];
    }
    return self;
}

/** bottom's subviews*/
- (void)addBottomSubviews
{
    [self addSubview:self.collectionView];
    
}
- (void)layoutSubviews
{
    
    self.height = [self getContentHeight];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.height);
    self.collectionView.contentInset = UIEdgeInsetsMake(topMargin, 0, 0, 0);
}


#pragma mark -- dataSource & delegate --

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _temArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DBMineBottomCell *cell = (DBMineBottomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:Mine_BottomCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleStr = _temArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomItemClick:)]) {
        [self.delegate bottomItemClick:indexPath.row];
    }
}

#pragma mark -- lazy --

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _temArr = @[@"我的订单", @"优惠券" ,@"我的收藏", @"我的足迹", @"地址管理", @"账号安全", @"联系客服", @"帮助中心", @"意见反馈", @"绑定手机"];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.minimumLineSpacing = linMargin;
        layout.minimumInteritemSpacing = linMargin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[DBMineBottomCell class] forCellWithReuseIdentifier:Mine_BottomCell];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _collectionView;
}


/**
 返回collection的高度

 @return 高度
 */
- (CGFloat) getContentHeight
{
    CGFloat h = itemH *(_temArr.count/3 + 1) + linMargin *(_temArr.count/3) + topMargin *2;
    return h;
}

@end
