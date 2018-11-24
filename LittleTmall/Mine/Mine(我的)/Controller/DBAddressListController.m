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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"地址管理";
    
    [self.view addSubview:self.bottomBuildBtn];
    self.tableView.height -= self.bottomBuildBtn.height;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    
    
    [self loadAddressData];
}

- (void)loadAddressData
{
    [BaseNetTool GetAddressListParams:nil block:^(NSMutableArray<DBAddressModel *> *modelArr, NSError *error) {
        if (!modelArr) {
            [self.tableView showNoDataViewImg:@"address" hintText:@"快去添加地址吧~" btnTitle:nil];
        } else {
            
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
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 *kScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBAddressBuildController *buildVC = [DBAddressBuildController new];
    buildVC.addressModel = self.addressArr[indexPath.row];
    buildVC.saveAddressBlock = ^(DBAddressModel *model) {
        [self.addressArr addObject:model];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:buildVC animated:YES];
}

#pragma mark -- DBAddressCellDelegate --
- (void)deleAddress:(DBAddressModel *)model
{
//    [self.addressArr removeObject:model];
//    [self.tableView reloadData];
    [self loadAddressData];
}

#pragma mark -- action --
- (void)buildNewAddress
{
    DBAddressBuildController *buildVC = [DBAddressBuildController new];
    buildVC.isNewBuild = YES;
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
        _bottomBuildBtn.backgroundColor = kMainColor;
        [_bottomBuildBtn.titleLabel setFont:kFont(16)];
        [_bottomBuildBtn setTitle:@"新建" forState:UIControlStateNormal];
        [_bottomBuildBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBuildBtn addTarget:self action:@selector(buildNewAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBuildBtn;
}


@end
