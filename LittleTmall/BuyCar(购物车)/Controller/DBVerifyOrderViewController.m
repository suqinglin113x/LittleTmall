//
//  DBVerifyOrderViewController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/27.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBVerifyOrderViewController.h"
#import "DBVerifyOrderHeader.h"
#import "DBCartListCell.h"
#import "DBVerifyOrderBottom.h"
#import "DBAddressBuildController.h"
#import "DBAddressListController.h"

@interface DBVerifyOrderViewController ()<UITableViewDelegate, UITableViewDataSource, DBVerifyOrderHeaderDelegate>

@property (strong, nonatomic) DBVerifyOrderHeader *headerView;
@property (nonatomic, strong) DBVerifyOrderBottom *bottomView;
@property (nonatomic, strong) NSMutableArray *cartList;

@end

@implementation DBVerifyOrderViewController
{
    BOOL _needBuild;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    self.navigationItem.title = @"确认订单";
    _needBuild = NO;
    [self.view addSubview:self.tableView];
    self.tableView.height -= self.bottomView.height;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.bottomView];
    
    [self loadPaymentData];
    
}

- (void)loadPaymentData
{
    DBWeakSelf
    NSDictionary *dict = @{@"addressId":@0,
                           @"couponId":@"",
                           @"type":@"cart"
                           };
    [BaseNetTool GetVerifyOrderParams:dict block:^(DBVerifyOrderModel *model, NSError *error) {
        self->_needBuild = model.checkedAddressModel.userId ? NO : YES;
        weakSelf.cartList = (NSMutableArray *)model.checkedGoodsList;
        weakSelf.headerView.orderModel = model;
        weakSelf.bottomView.orderModel = model;
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cartList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celID = @"aaaaaa";
    DBCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:celID];
    if (cell == nil) {
        cell = [[DBCartListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celID];
    }
    
    cell.carListModel = self.cartList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95 *kScale;
}

#pragma mark -- DBVerifyOrderHeaderDelegate --
- (void)chooseAddress
{
    if (_needBuild) { // 新建页面
        DBAddressBuildController *addressVC = [DBAddressBuildController new];
        [self.navigationController pushViewController:addressVC animated:YES];
    } else {
        DBAddressListController *listVC = [DBAddressListController new];
        listVC.isFromCart = YES;
        [self.navigationController pushViewController:listVC animated:YES];
    }
    
}
- (void)chooseCoupon
{
#warning codeing here
}

#pragma mark -- lazy --

- (NSMutableArray *)cartList
{
    if (_cartList == nil) {
        _cartList = [NSMutableArray array];
    }
    return _cartList;
}

- (DBVerifyOrderHeader *)headerView
{
    if (_headerView == nil) {
        _headerView = [[DBVerifyOrderHeader alloc] initWithFrame:CGRectZero];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 300 *kScale);
        _headerView.delegate = self;
    }
    return _headerView;
}

- (DBVerifyOrderBottom *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[DBVerifyOrderBottom alloc] init];
        _bottomView.frame = CGRectMake(0, kScreenHeight - 60 *kScale, kScreenWidth, 60 *kScale);
        
    }
    return _bottomView;
}
@end
