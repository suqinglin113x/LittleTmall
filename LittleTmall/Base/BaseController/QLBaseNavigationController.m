//
//  QLBaseNavigationController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLBaseNavigationController.h"

@interface QLBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation QLBaseNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor whiteColor];
    navBar.tintColor = [UIColor blackColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                   NSFontAttributeName : [UIFont systemFontOfSize:17 *kScale]
                                   };
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 处理手势返回失效
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count >= 1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}




@end
