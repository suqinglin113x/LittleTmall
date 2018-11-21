//
//  DBAddressBuildController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBAddressBuildController.h"

@interface DBAddressBuildController ()<UITextFieldDelegate>

@end

@implementation DBAddressBuildController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"地址编辑";
    
    [self createUI];
    
}

- (void)createUI
{
    NSArray *placeHolder = @[@"姓名", @"手机号码", @"省份、城市、区县", @"详细地址，如街道、楼盘号等"];
    for (NSInteger i = 0; i < 4; i ++) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = placeHolder[i];
        textField.textColor = kTextColor;
        textField.font = kFont(15);
        CGFloat leftMargin = 15 *kScale;
        UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftMargin, 1)];
        textField.leftView = leftV;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.delegate = self;
        textField.tag = i;
        
        CGFloat hei = 60 *kScale;
        textField.frame = CGRectMake(0, (hei + 1) *i, kScreenWidth, hei);
        [self.view addSubview:textField];
        // 线条
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, (hei+1) *(i+1), kScreenWidth, 1)];
        lineV.backgroundColor = UIColorFromHex(0xbebec0);
        [self.view addSubview:lineV];
        
        if (i == 1) {
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        if (i == 2) {
            DBLog(@"点击了地址栏");
            [textField addTarget:self action:@selector(showAddressView) forControlEvents:UIControlEventTouchDown];
        }
        
    }
}

- (void)showAddressView
{
    [self.view endEditing:YES];
    
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2) {
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
