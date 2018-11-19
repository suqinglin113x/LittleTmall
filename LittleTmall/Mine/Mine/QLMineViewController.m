//
//  QLMineViewController.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLMineViewController.h"
#import "QLMineTopView.h"
#import "QLMineBottomView.h"

@interface QLMineViewController ()

@property (nonatomic, strong) UITableView *tab;

@property (nonatomic, strong) QLMineTopView *mineTopView;

@property (nonatomic, strong) QLMineBottomView *mineBottomView;

@end

@implementation QLMineViewController

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

- (QLMineTopView *)mineTopView
{
    if (_mineTopView == nil) {
        CGFloat mineTopViewH = 220 *kScale;
        _mineTopView = [[QLMineTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, mineTopViewH)];
    }
    return _mineTopView;
}

- (QLMineBottomView *)mineBottomView
{
    if (_mineBottomView == nil) {
        _mineBottomView = [[QLMineBottomView alloc] init];
        CGFloat mineBottomViewH = [_mineBottomView getContentHeight];
        _mineBottomView.frame = CGRectMake(0, self.mineTopView.bottom, kScreenWidth, mineBottomViewH);
    }
    return _mineBottomView;
}



@end
