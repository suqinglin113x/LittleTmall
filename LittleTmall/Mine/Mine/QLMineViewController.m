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

@property (nonatomic, strong) QLMineTopView *mineTopView;

@property (nonatomic, strong) QLMineBottomView *mineBottomView;

@end

@implementation QLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    // topView
    [self.view addSubview:self.mineTopView];
    
    // bottomView
    [self.view addSubview:self.mineBottomView];
}

#pragma mark -- lazy --
- (QLMineTopView *)mineTopView
{
    if (_mineTopView == nil) {
        CGFloat mineTopViewH = 200 *kScale;
        _mineTopView = [[QLMineTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, mineTopViewH)];
    }
    return _mineTopView;
}

- (QLMineBottomView *)mineBottomView
{
    if (_mineBottomView == nil) {
        CGFloat mineBottomViewH = kScreenWidth;
        _mineBottomView = [[QLMineBottomView alloc] initWithFrame:CGRectMake(0, self.mineTopView.bottom, kScreenWidth, mineBottomViewH)];
    }
    return _mineBottomView;
}



@end
