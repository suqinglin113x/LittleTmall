//
//  DBLoginViewController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBLoginViewController.h"

@interface DBLoginViewController ()
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UITextField *pictureTF;
@property (nonatomic, strong) UIButton *getSMSBtn;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation DBLoginViewController
{
    
    NSInteger time;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录斗宝";
    
    [self createTopSubviews];
}

- (void)createTopSubviews
{
    
    CGFloat height = 60*kScale;
    CGFloat leftMargin = 15 *kScale;
    
    UIImageView *logoIV = [[UIImageView alloc] init];
    logoIV.frame = CGRectMake(0, 30 *kScale, 80 *kScale, 80 *kScale);
    logoIV.centerX = self.view.centerX;
    logoIV.layer.cornerRadius = logoIV.width *0.5;
    logoIV.layer.masksToBounds = YES;
    logoIV.image = [UIImage imageNamed:@"mine_headImage"];
    [self.view addSubview:logoIV];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.frame = CGRectMake(0, logoIV.bottom, logoIV.width, 30 *kScale);
    titleL.centerX = logoIV.centerX;
    titleL.font = kFont(15);
    titleL.textAlignment = 1;
    titleL.text = @"斗宝商城";
    [self.view addSubview:titleL];
    
    //
    UILabel *tipL = [[UILabel alloc] init];
    tipL.frame = CGRectMake(leftMargin, titleL.bottom + 30 *kScale, 100*kScale, 30 *kScale);
    tipL.font = kFont(15);
    tipL.textAlignment = 0;
    tipL.text = @"快速登录";
    [self.view addSubview:tipL];
    
    NSArray *titleS = @[@"手机号码",@"验证码", @"图片验证码"];
    NSArray *placeholderS = @[@"请输入手机号码",@"请输入验证码", @"请输入图形验证码"];
    for (int i =0; i <titleS.count; i ++) {
      
        UIView *itemView = [[UIView alloc] init];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.frame = CGRectMake(0, tipL.bottom +5*kScale + (height+1) *i, kScreenWidth, height);
        [self.view addSubview:itemView];
        // ----- 手机号码
        UILabel *titleL = [[UILabel alloc] init];
        titleL.frame = CGRectMake(leftMargin, 0, 80*kScale, height);
        titleL.font = kFont(15);
        titleL.textAlignment = 0;
        titleL.text = titleS[i];
        titleL.backgroundColor = [UIColor whiteColor];
        [itemView addSubview:titleL];
        UITextField *TF = [[UITextField alloc] init];
        TF.frame = CGRectMake(titleL.right, titleL.top, kScreenWidth, height);
        TF.placeholder = placeholderS[i];
        TF.font = kFont(15);
        TF.keyboardType = UIKeyboardTypePhonePad;
        TF.backgroundColor = [UIColor whiteColor];
        [itemView addSubview:TF];
        if (i == 0) {
            self.phoneTF = TF;
            UIButton *getSMSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.getSMSBtn = getSMSBtn;
            getSMSBtn.frame = CGRectMake(TF.width - 100*kScale, 0, 80*kScale, 30*kScale);
            getSMSBtn.centerY = TF.centerY;
            [getSMSBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [getSMSBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [getSMSBtn setBackgroundColor:kMainColor];
            [getSMSBtn.titleLabel setFont:kFont(13)];
            [getSMSBtn addTarget:self action:@selector(getSMSBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [itemView addSubview:getSMSBtn];
        }
        //
        UIView *lineV = [[UIView alloc] init];
        lineV.backgroundColor = kBgColor;
        lineV.frame = CGRectMake(0, itemView.bottom +1, kScreenWidth, 1);
        [self.view addSubview:lineV];
        
        if (i == 1) {
            self.codeTF = TF;
        }
        if (i == 2) {
            self.pictureTF = TF;
            self.pictureTF.hidden = itemView.hidden = YES;
        }
    }
    
    CGFloat totalHeight = 0;
    totalHeight = tipL.bottom + (self.pictureTF.hidden ?(height+1)*(titleS.count-1):(height+1)*titleS.count);
    // ------ 登录
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat loginBtnY = totalHeight +50 *kScale;
    loginBtn.layer.cornerRadius = 5 *kScale;
    loginBtn.frame = CGRectMake(20*kScale, loginBtnY, kScreenWidth - 40*kScale, 50*kScale);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:kMainColor];
    [loginBtn.titleLabel setFont:kFont(15)];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

#pragma mark -- action
- (void)getSMSBtnClick
{
    [self.view endEditing:YES];
    time = 60;
    NSDictionary *dict = @{@"mobile":self.phoneTF.text};
    [BaseNetTool GetSMSWithParams:dict block:^(id response, NSError *error) {
        if (response) {
            [MBProgressHUD showSuccess:@"获取验证码成功！"];
            [self startDownTimer];
        }
    }];
}

-  (void)loginBtnClick
{
    [self.view endEditing:YES];
    NSDictionary *dict = @{@"mobile":self.phoneTF.text,
                           @"code":self.codeTF.text
                           };
    [BaseNetTool GetLoginWithParams:dict block:^(id response, NSError *error) {
        if (response) {
            [MBProgressHUD showSuccess:@"登录成功！"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}

- (void)startDownTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(minusTime) userInfo:nil repeats:YES];
}
- (void)minusTime
{
    time --;
    if (time == 0) {
        [self.getSMSBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer  = nil;
        return;
    } else {
        [self.getSMSBtn setTitle:[NSString stringWithFormat:@"%02ld", time] forState:UIControlStateNormal];
    }
}

@end
