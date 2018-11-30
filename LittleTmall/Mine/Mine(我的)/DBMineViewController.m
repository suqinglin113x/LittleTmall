//
//  DBMineViewController.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBMineViewController.h"
#import "DBMineTopView.h"
#import "DBMineBottomView.h"
#import "DBOrderListViewController.h"
#import "DBAddressListController.h"
#import "DBOpinionFeedbackController.h"
#import "DBLoginViewController.h"
#import "DBAccountViewController.h"

@interface DBMineViewController ()<DBMineBottomViewDelegate>

@property (nonatomic, strong) UITableView *tab;

@property (nonatomic, strong) DBMineTopView *mineTopView;

@property (nonatomic, strong) DBMineBottomView *mineBottomView;

@end

@implementation DBMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
   
    [self loadMineData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
#warning 暂存一份token
    DBLoginModel *model = [DBLoginModel new];
    model.token = @"1f8kapb1xinuc0l002k7e6jxei460wds";
    [BaseUserTool saveUserInfo:model];
    
    // topView
    self.tab.tableHeaderView = self.mineTopView;
    
    // bottomView
    UIView *fddfd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    fddfd.backgroundColor = [UIColor redColor];
    self.tab.tableFooterView = self.mineBottomView;
    
}


#pragma mark -- DBMineBottomViewDelegate --
 - (void)bottomItemClick:(NSInteger)currentIndex
{
    DBLog(@"当前点击的item:%ld", currentIndex);
    if (currentIndex == 0 ||currentIndex == 1 ||currentIndex == 2 ||currentIndex == 3 ||currentIndex == 4 ||currentIndex == 5 ){
        if(![BaseUserTool getToken]) {
            [self goToLogin];
        } else {
            if (currentIndex == 0) { // 地址管理
                DBOrderListViewController *addressVC = [DBOrderListViewController new];
                [self.navigationController pushViewController:addressVC animated:YES];
            }
            if (currentIndex == 4) { // 地址管理
                DBAddressListController *addressVC = [DBAddressListController new];
                [self.navigationController pushViewController:addressVC animated:YES];
            }
            if (currentIndex == 5) { // 账号安全
                DBAccountViewController *addressVC = [DBAccountViewController new];
                [self.navigationController pushViewController:addressVC animated:YES];
            }
           
        }
    } else {
        if (currentIndex == 8) {// 意见范反馈
            DBOpinionFeedbackController *opinionVC = [DBOpinionFeedbackController new];
            [self.navigationController pushViewController:opinionVC animated:YES];
        }
    }
}

#pragma mark -- action ---
-(void)loadMineData
{
    [BaseNetTool GetMineParams:nil block:^(NSString *coinStr, NSError *error) {
        if ([coinStr containsString:@"请重新登录"]){
            [BaseUserTool deleteUserInfo];
            
        } else {
            
            self.mineTopView.coinStr = coinStr;
        }
    }];
}

/** 前去登录*/
- (void)goToLogin
{
    DBLoginViewController *loginVC = [DBLoginViewController new];
    [self.navigationController pushViewController:loginVC animated:YES];
   
}
- (void)showAlertmessage:(NSString *)message
{
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    DBWeakSelf
    UIAlertAction *sureA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DBLoginViewController *loginVC = [DBLoginViewController new];
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
    }];
    [alertV addAction:cancelA];
    [alertV addAction:sureA];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertV animated:YES completion:nil];
}
#pragma mark -- lazy --

- (UITableView *)tab
{
    if (_tab == nil) {
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeigth)];
        _tab.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tab];
        _tab.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    return _tab;
}

- (DBMineTopView *)mineTopView
{
    if (_mineTopView == nil) {
         CGFloat mineTopViewH = 0;
        if([BaseUserTool getToken]) {
            mineTopViewH = 220 *kScale;
        } else {
            mineTopViewH = 150 *kScale;
        }
       
        _mineTopView = [[DBMineTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, mineTopViewH)];
    }
    return _mineTopView;
}


- (DBMineBottomView *)mineBottomView
{
    if (_mineBottomView == nil) {
        _mineBottomView = [[DBMineBottomView alloc] init];
        CGFloat mineBottomViewH = [_mineBottomView getContentHeight];
        _mineBottomView.frame = CGRectMake(0, self.mineTopView.bottom, kScreenWidth, mineBottomViewH);
        _mineBottomView.delegate = self;
    }
    return _mineBottomView;
}



@end
