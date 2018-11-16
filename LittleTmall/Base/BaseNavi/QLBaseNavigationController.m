//
//  QLBaseNavigationController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLBaseNavigationController.h"

@interface QLBaseNavigationController ()

@end

@implementation QLBaseNavigationController

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor blackColor];
    navBar.barTintColor = kMainColor;
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                   NSFontAttributeName : [UIFont systemFontOfSize:17]
                                   };
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
