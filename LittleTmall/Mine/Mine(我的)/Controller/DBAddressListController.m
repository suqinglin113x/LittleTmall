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


@interface DBAddressListController ()
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
    NSDictionary * dict = @{@"userName":@"芸芸",
                            @"addressStr":@"北京朝阳区三环以内马家堡西里192号楼3单元102",
                            @"phoneNum":@"13261669965"};
    NSArray *loadData = @[dict, dict, dict, dict, dict, dict, dict, dict];
    self.addressArr = [DBAddressModel modelWithDicArr:loadData];
    if (!self.addressArr.count) {
        [self.tableView showNoDataViewImg:@"address" hintText:@"快去添加地址吧~" btnTitle:nil];
    }
    [self.tableView reloadData];
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
    cell.addressModel = self.addressArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90 *kScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBAddressBuildController *buildVC = [DBAddressBuildController new];
    buildVC.saveAddressBlock = ^(DBAddressModel *model) {
        [self.addressArr addObject:model];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:buildVC animated:YES];
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
