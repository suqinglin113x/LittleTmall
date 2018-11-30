//
//  DBAddressListController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBAddressListController.h"
#import "DBAddressCell.h"
#import "DBAddressModel.h"
#import "DBAddressBuildController.h"


@interface DBAddressListController ()<DBAddressCellDelegate>
@property (nonatomic, strong) UIButton *bottomBuildBtn;
// 存放地址的数组
@property (nonatomic, strong) NSMutableArray *addressArr;

@end

@implementation DBAddressListController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadAddressData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"地址管理";
    
    [self.view addSubview:self.bottomBuildBtn];
    self.tableView.height -= self.bottomBuildBtn.height;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
  
}

- (void)loadAddressData
{
    [BaseNetTool GetAddressListParams:nil block:^(NSMutableArray<DBAddressModel *> *modelArr, NSError *error) {
        if (modelArr.count == 0) {
            [self.tableView showNoDataViewImg:@"address" hintText:@"快去添加地址吧~" btnTitle:nil];
        } else {
            [self.tableView hideNoDataView];
            self.addressArr = modelArr;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark -- datasource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [super tableView:tableView numberOfRowsInSection:section];
    return self.addressArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBAddressCell"];
    if (cell == nil) {
        cell = [[DBAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DBAddressCell"];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.delegate = self;
    cell.addressModel = self.addressArr[indexPath.row];
    cell.isFromCart = self.isFromCart;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 *kScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isFromCart) { // 来自购物车
#warning codeing here 处理地址回调
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        DBAddressBuildController *buildVC = [DBAddressBuildController new];
        buildVC.addressModel = self.addressArr[indexPath.row];
        buildVC.saveAddressBlock = ^(DBAddressModel *model) {
            [self.addressArr addObject:model];
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:buildVC animated:YES];
    }
   
}

#pragma mark -- DBAddressCellDelegate --
- (void)deleOrEditAddress:(DBAddressModel *)model
{
    if (self.isFromCart) {
        DBAddressBuildController *buildVC = [DBAddressBuildController new];
        buildVC.addressModel = model;
        [self.navigationController pushViewController:buildVC animated:YES];
    } else {
        
        [self loadAddressData];
    }
}

#pragma mark -- action --
- (void)buildNewAddress
{
    DBAddressBuildController *buildVC = [DBAddressBuildController new];
//    buildVC.isNewBuild = YES;
    buildVC.saveAddressBlock = ^(DBAddressModel *model) {
        [self.addressArr addObject:model];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:buildVC animated:YES];
}


#pragma mark -- lazy --
- (NSMutableArray *)addressArr
{
    if (_addressArr == nil) {
        
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
}

- (UIButton *)bottomBuildBtn
{
    if (_bottomBuildBtn == nil) {
        _bottomBuildBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight -kNavBarAndStatusBarHeight - 50 *kScale, kScreenWidth, 50 *kScale)];
        [_bottomBuildBtn az_setGradientBackgroundWithColors:@[kMainBeginColor, kMainEndColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        [_bottomBuildBtn.titleLabel setFont:kFont(16)];
        [_bottomBuildBtn setTitle:@"新建" forState:UIControlStateNormal];
        [_bottomBuildBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBuildBtn addTarget:self action:@selector(buildNewAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBuildBtn;
}


@end
