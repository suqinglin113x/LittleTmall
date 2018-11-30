//
//  DBMainViewController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBMainViewController.h"
#import "DBVerifyOrderViewController.h"
#import "DBLoginViewController.h"

@interface DBMainViewController ()

@end

@implementation DBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[DBLoginViewController new] animated:YES];
    
}



@end
