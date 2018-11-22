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
#import "DBAddressListController.h"
#import "DBOpinionFeedbackController.h"

@interface DBMineViewController ()<DBMineBottomViewDelegate>

@property (nonatomic, strong) UITableView *tab;

@property (nonatomic, strong) DBMineTopView *mineTopView;

@property (nonatomic, strong) DBMineBottomView *mineBottomView;

@end

@implementation DBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
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
    if (currentIndex == 4) {
        DBAddressListController *addressVC = [DBAddressListController new];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    if (currentIndex == 8) {
        DBOpinionFeedbackController *opinionVC = [DBOpinionFeedbackController new];
        [self.navigationController pushViewController:opinionVC animated:YES];
    }
}

#pragma mark -- lazy --

- (UITableView *)tab
{
    if (_tab == nil) {
        _tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeigth - kNavBarAndStatusBarHeight)];
        _tab.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tab];
    }
    return _tab;
}

- (DBMineTopView *)mineTopView
{
    if (_mineTopView == nil) {
        CGFloat mineTopViewH = 220 *kScale;
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
