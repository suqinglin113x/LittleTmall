//
//  QLBuyCarViewController.m
//  LittleTmall
//
//  Created by 苏庆林 on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLBuyCarViewController.h"
#import "UITableView+EmptyDataView.h"

@interface QLBuyCarViewController ()

@end

@implementation QLBuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:table];
    
    table.tableFooterView = [UIView new];
    [table showNoDataViewImg:@"购物车" text:@"购物车空空如也~" btn:@"去逛逛"];
}



@end
