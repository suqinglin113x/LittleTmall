//
//  DBBuyCarViewController.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBBuyCarViewController.h"
#import "DBCarBottomBar.h"
#import "DBCarBuyCell.h"

#define barHei  50 *kScale

@interface DBBuyCarViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) DBCarBottomBar *bottomBar;
@property (nonatomic, strong) NSMutableArray *dataSource;
// 存放购买的商品
@property (strong, nonatomic) NSMutableArray *resultBuyArr;
// 存放删除的商品
@property (strong, nonatomic) NSMutableArray *resultDelArr;

@property (assign, nonatomic) BOOL isEditing;
@end

@implementation DBBuyCarViewController

- (UIView *)sloganV:(NSArray *)textArr
{
    UIView *sloganV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    sloganV.backgroundColor = kBgColor;
    for (NSInteger i = 0; i < textArr.count; i ++) {
        UILabel *slogan = [[UILabel alloc] initWithFrame:CGRectMake(30+kScreenWidth/3.0 *i, 0, kScreenWidth/3.0, 35)];
        slogan.text = textArr[i];
        slogan.font = kFont(13);
        [sloganV addSubview:slogan];
        UIView *circle = [[UIView alloc] init];
        circle.frame = CGRectMake(-10, 0, 5, 5);
        circle.centerY = slogan.centerY;
        circle.layer.cornerRadius = 2.5;
        circle.layer.borderWidth = 1;
        circle.layer.borderColor = kMainColor.CGColor;
        [slogan addSubview:circle];
    }
   
    return sloganV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"购物车";
    self.tabView.tableHeaderView = [self sloganV:@[@"30天无忧退货", @"48小时快速退款", @"免运费"]];
   
    [self.view addSubview:self.tabView];
    
    if (self.dataSource.count) {
        [self.tabView reloadData];
    } else {
        [self.tabView showNoDataViewImg:@"购物车" hintText:@"购物车空空如也~" btnTitle:@"去逛逛"];
        self.tabView.tableFooterView = [UIView new];
    }
    
    // 底部工具条
    [self.view addSubview:self.bottomBar];
    
    //  添加 resultBuyArr
    [self addObserver:self forKeyPath:@"self.resultBuyArr" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"self.resultDelArr" options:NSKeyValueObservingOptionNew context:nil];
    
    [self dealChooseAllBlock];
    
    
    [self dealEditBlock];
    
}
//MARK: 全选
- (void)dealChooseAllBlock
{
    MJWeakSelf
    self.bottomBar.chooseAllBlock = ^(BOOL isSelected){
        DBLog(@"执行全选操作");
        
        if (isSelected) {
            if (weakSelf.isEditing) {// 编辑状态下
                [weakSelf.resultDelArr removeAllObjects];
                [weakSelf dealselectRowArrName:@"resultDelArr"];
            } else {
                [weakSelf.resultBuyArr removeAllObjects];
                [weakSelf dealselectRowArrName:@"resultBuyArr"];
            }
            
        } else {
            // 全部取消选中
            if (weakSelf.isEditing) {
                [weakSelf dealDeselectRowArrName:@"resultDelArr"];
            } else {
                [weakSelf dealDeselectRowArrName:@"resultBuyArr"];
            }
        }
    };
}
/** 全选中*/
- (void)dealselectRowArrName:(NSString *)arrName
{
    MJWeakSelf
    for (NSInteger i = 0; i < weakSelf.dataSource.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [weakSelf.tabView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        // 数组必须保存对应的indePath
        [[weakSelf mutableArrayValueForKey:arrName] addObject:@(indexPath.row)];
    }
}
/** 反选*/
- (void)dealDeselectRowArrName:(NSString *)arrName
{
    MJWeakSelf
    [[self mutableArrayValueForKey:arrName] removeAllObjects];
    for (NSInteger i = 0; i < weakSelf.dataSource.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.tabView deselectRowAtIndexPath:indexPath animated:NO];
    }
}
//MARK: 编辑
- (void)dealEditBlock
{
    MJWeakSelf
    self.bottomBar.editBlock = ^(BOOL isSelected) {
        
        [weakSelf.tabView reloadData];
        weakSelf.isEditing = isSelected;
        
        if (isSelected) {
            //全部取消选中(默认)
            [weakSelf dealDeselectRowArrName:@"resultDelArr"];
            weakSelf.resultDelArr = [NSMutableArray array];
        } else {
            // 重新选择购买的
            for (NSInteger i = 0; i < weakSelf.resultBuyArr.count; i ++) {
                NSInteger row = [weakSelf.resultBuyArr[i] integerValue];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                [weakSelf.tabView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
            // 重新赋值
            weakSelf.resultBuyArr = weakSelf.resultBuyArr;;
        }
    };
}
#pragma mark -- datesource &&  delegate --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DBCarBuyCell";
    DBCarBuyCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DBCarBuyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell cellEditingStatus:self.isEditing];
    cell.productStr = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBLog(@"点击的cell：%ld", (long)indexPath.row);
    
    if (_isEditing) {
        [[self mutableArrayValueForKey:@"resultDelArr"] addObject:@(indexPath.row)];
    } else {
        [[self mutableArrayValueForKey:@"resultBuyArr"] addObject:@(indexPath.row)];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditing) {
         [[self mutableArrayValueForKey:@"resultDelArr"] removeObject:@(indexPath.row)];
    } else {
         [[self mutableArrayValueForKey:@"resultBuyArr"] removeObject:@(indexPath.row)];
    }
   
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

#pragma mark -- observe ---
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"self.resultBuyArr"]) {
        self.bottomBar.dataArr = self.resultBuyArr;
        if (self.resultBuyArr.count != self.dataSource.count) {
            self.bottomBar.tickImgBtn.selected = NO;
        } else {
            self.bottomBar.tickImgBtn.selected = YES;
        }
    } else if([keyPath isEqualToString:@"self.resultDelArr"]) {
        self.bottomBar.dataArr = self.resultDelArr;
        if (self.resultDelArr.count != self.dataSource.count) {
            self.bottomBar.tickImgBtn.selected = NO;
        } else {
            self.bottomBar.tickImgBtn.selected = YES;
        }
    }
}

#pragma mark -- lazy --
- (UITableView *)tabView
{
    if (_tabView == nil) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tabView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatusBarHeight - kTabBarHeigth - barHei);
        _tabView.dataSource = self;
        _tabView.delegate = self;
        _tabView.editing = YES;
    }
    return _tabView;
}

- (DBCarBottomBar *)bottomBar
{
    if (_bottomBar == nil) {
        _bottomBar = [[DBCarBottomBar alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavBarAndStatusBarHeight - barHei - kTabBarHeigth, kScreenWidth, barHei)];
    }
    return _bottomBar;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 1; i <= 20; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"打两节课的价位大%02ld", (long)i]];
        }
    }
    return _dataSource;
}
- (NSMutableArray *)resultBuyArr
{
    if (_resultBuyArr == nil) {
        _resultBuyArr = [NSMutableArray array];
    }
    return _resultBuyArr;
}
- (NSMutableArray *)resultDelArr
{
    if (_resultDelArr == nil) {
        _resultDelArr = [NSMutableArray array];
        _resultDelArr = [NSMutableArray array];
    }
    return _resultDelArr;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"resultBuyArr"];
    [self removeObserver:self forKeyPath:@"resultDelArr"];
}
@end
