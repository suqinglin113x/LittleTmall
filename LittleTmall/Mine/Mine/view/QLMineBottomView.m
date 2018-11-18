//
//  QLMineBottomView.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/17.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLMineBottomView.h"
#import "QLMineBottomCell.h"

#define margin 5

@interface QLMineBottomView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *temArr;

@end
@implementation QLMineBottomView

static NSString *const Mine_BottomCell = @"QLMineBottomCell";

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
    self.collectionView.frame = self.bounds;
    self.collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
}


#pragma mark -- dataSource & delegate --

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _temArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    QLMineBottomCell *cell = (QLMineBottomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:Mine_BottomCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.layer.cornerRadius = 10;
    cell.titleStr = _temArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"当前点击cell：%ld", indexPath.row);
}

#pragma mark -- lazy --

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _temArr = @[@"你大", @"爷的" ,@"徐炜", @"芸，", @"死到", @"哪里", @"去了", @"😕😒"];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenWidth - 20) /3, (kScreenWidth - 20) /3);
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[QLMineBottomCell class] forCellWithReuseIdentifier:Mine_BottomCell];
        _collectionView.backgroundColor = [UIColor redColor];
        
    }
    return _collectionView;
}


@end
