//
//  QLBuyCarViewController.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLBuyCarViewController.h"
#import "UITableView+EmptyDataView.h"
#import "QLCarBottomBar.h"
#import "QLCarBuyCell.h"

#define barHei  50 *kScale

@interface QLBuyCarViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) QLCarBottomBar *bottomBar;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *deleteArr;

@end

@implementation QLBuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";
    
    [self.view addSubview:self.tabView];
    
    if (self.dataSource.count) {
        [self.tabView reloadData];
    } else {
        self.tabView.tableFooterView = [UIView new];
        [self.tabView showNoDataViewImg:@"购物车" text:@"购物车空空如也~" btn:@"去逛逛"];
    }
    
    // 底部工具条
    [self.view addSubview:self.bottomBar];
    
    
    // 全选
    MJWeakSelf
    self.bottomBar.chooseAllBlock = ^(BOOL isSelected){
        QLLog(@"执行全选操作");
        if (isSelected) {
            // 全选中
            [weakSelf.deleteArr addObjectsFromArray:weakSelf.dataSource];
            for (NSInteger i = 0; i < weakSelf.dataSource.count; i ++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [weakSelf.tabView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                
            }
            weakSelf.bottomBar.dataArr = weakSelf.dataSource;
        } else {
            // 全部取消选中
            [weakSelf.deleteArr removeAllObjects];
            for (NSInteger i = 0; i < weakSelf.dataSource.count; i ++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [weakSelf.tabView deselectRowAtIndexPath:indexPath animated:NO];
            }
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
    static NSString *cellIdentifier = @"QLCarBuyCell";
    QLCarBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QLCarBuyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.deleteArr addObject:[self.dataSource objectAtIndex:indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.deleteArr removeObject:[self.dataSource objectAtIndex:indexPath.row]];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
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

- (QLCarBottomBar *)bottomBar
{
    if (_bottomBar == nil) {
        _bottomBar = [[QLCarBottomBar alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavBarAndStatusBarHeight - barHei - kTabBarHeigth, kScreenWidth, barHei)];
    }
    return _bottomBar;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 1; i <= 20; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"商品%02ld", i]];
        }
    }
    return _dataSource;
}
- (NSMutableArray *)deleteArr
{
    if (_deleteArr == nil) {
        _deleteArr = [NSMutableArray array];
    }
    return _deleteArr;
}
@end
