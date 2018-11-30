//
//  DBOrderListViewController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/25.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBOrderListViewController.h"
#import "DBOrderListsCell.h"

@interface DBOrderListViewController ()
@property (nonatomic, strong) NSMutableArray *orderLists;
@end

@implementation DBOrderListViewController
{
    NSUInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    [self.view addSubview:self.tableView];
    
    [self addMJRefresh];
    [self.tableView.mj_header beginRefreshing];
}

- (void)addMJRefresh
{
    
    [self.tableView showNoDataViewImg:@"" hintText:@"暂无订单" btnTitle:nil];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->_page = 1;
        [self.orderLists removeAllObjects];
        [self loadOrderLists];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->_page ++;
        [self loadOrderLists];
    }];
}
- (void)loadOrderLists
{
    NSDictionary *dict = @{@"page": @(_page),
                           @"size":@(10)
                          };
    [BaseNetTool GetOrderListParams:dict block:^(NSArray *orderLists, NSError *error) {
        if(self->_page == 1) {
            if (orderLists.count == 0) {
            } else {
                [self.orderLists addObjectsFromArray:orderLists];
                [self.tableView hideNoDataView];
            }
        } else {
            if (orderLists.count == 0) {
                self->_page --;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.orderLists addObjectsFromArray:orderLists];
                [self.tableView.mj_footer endRefreshing];
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"DBOrderListsCell";
    DBOrderListsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DBOrderListsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.model = self.orderLists[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95 *kScale;
}
#pragma mark -- lazy --
- (NSMutableArray *)orderLists
{
    if(_orderLists == nil) {
        _orderLists = [NSMutableArray array];
    }
    return _orderLists;
}
@end
