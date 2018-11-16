//
//  QLBaseTabBarController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "QLBaseTabBarController.h"
#import "QLBaseNavigationController.h"
#import "QLMainViewController.h"
#import "QLCategoryViewController.h"


@interface QLBaseTabBarController ()

@end

@implementation QLBaseTabBarController

+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *attrsSele = [NSMutableDictionary dictionary];
    attrsSele[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrsSele[NSForegroundColorAttributeName] = [UIColor yellowColor];
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSele forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SetupAllControllers];
}

/** add childVCs*/
- (void)SetupAllControllers {
    
    [self addChildVc:[QLMainViewController new] title:@"首页" image:@"账单点击前" selectedImage:@"账单点击后"];
    
    [self addChildVc:[QLCategoryViewController new] title:@"类目" image:@"图表点击前" selectedImage:@"图表点击后"];
    
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    QLBaseNavigationController *navi = [[QLBaseNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // vc单独设置
//    childVc.navigationItem.title = title;
    [self addChildViewController:navi];
}



@end
