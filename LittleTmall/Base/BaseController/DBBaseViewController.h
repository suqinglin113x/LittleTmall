//
//  DBBaseViewController.h
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBBaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end
