//
//  DBBaseTabBarController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/16.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBBaseTabBarController.h"
#import "DBBaseNavigationController.h"
#import "DBMainViewController.h"
#import "DBCategoryViewController.h"
#import "DBBuyCarViewController.h"
#import "DBMineViewController.h"

@interface DBBaseTabBarController ()

@end

@implementation DBBaseTabBarController

+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *attrsSele = [NSMutableDictionary dictionary];
    attrsSele[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrsSele[NSForegroundColorAttributeName] = kMainColor;
    
    
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
    
    [self addChildVc:[DBMainViewController new] title:@"首页" image:@"账单点击前" selectedImage:@"账单点击后"];
    
    [self addChildVc:[DBCategoryViewController new] title:@"类目" image:@"图表点击前" selectedImage:@"图表点击后"];
   
    [self addChildVc:[DBBuyCarViewController new] title:@"购物车" image:@"流水点击前" selectedImage:@"流水点击后"];
    
    [self addChildVc:[DBMineViewController new] title:@"我的" image:@"我的点击前" selectedImage:@"我的点击后"];
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    DBBaseNavigationController *navi = [[DBBaseNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // vc单独设置
//    childVc.navigationItem.title = title;
    [self addChildViewController:navi];
}



@end
