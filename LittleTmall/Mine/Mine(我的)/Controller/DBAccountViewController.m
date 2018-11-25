//
//  DBAccountViewController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/25.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBAccountViewController.h"

@interface DBAccountViewController ()

@end

@implementation DBAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号安全";
    
    CGFloat margin = 15 *kScale;
    
    UIButton *sign_outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sign_outBtn.backgroundColor = kMainColor;
    sign_outBtn.frame = CGRectMake(margin, 300, kScreenWidth - margin *2, 40 *kScale);
    [sign_outBtn.titleLabel setFont:kFont(14)];
    [sign_outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [sign_outBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sign_outBtn addTarget:self action:@selector(signoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sign_outBtn];
    
}

- (void)signoutBtnClick
{
    [BaseUserTool deleteUserInfo];
//    [BaseNetTool SignoutParams:nil block:^(id response, NSError *error) {
//
//    }];
}

@end
