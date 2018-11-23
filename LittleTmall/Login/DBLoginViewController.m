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
    
    // ----- 手机号码
    UILabel *phoneL = [[UILabel alloc] init];
    phoneL.frame = CGRectMake(0, tipL.bottom +5*kScale, 80*kScale, height);
    phoneL.font = kFont(15);
    phoneL.textAlignment = 0;
    phoneL.text = @"手机号码";
    phoneL.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneL];
    UITextField *phoneTF = [[UITextField alloc] init];
    self.phoneTF = phoneTF;
    phoneTF.frame = CGRectMake(phoneL.right, phoneL.top, kScreenWidth, height);
    phoneTF.placeholder = @"请输入手机号码";
    phoneTF.font = kFont(15);
    phoneTF.keyboardType = UIKeyboardTypePhonePad;
    phoneTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneTF];
    UIButton *getSMSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getSMSBtn = getSMSBtn;
    getSMSBtn.frame = CGRectMake(phoneTF.width - 100*kScale, 0, 80*kScale, 30*kScale);
    getSMSBtn.centerY = phoneTF.centerY;
    [getSMSBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getSMSBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getSMSBtn setBackgroundColor:kMainColor];
    [getSMSBtn.titleLabel setFont:kFont(13)];
    [getSMSBtn addTarget:self action:@selector(getSMSBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getSMSBtn];
    
    //
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = kBgColor;
    lineV.frame = CGRectMake(0, phoneTF.bottom +1, kScreenWidth, 1);
    [self.view addSubview:lineV];
    
    // ----- 验证码
    UILabel *codeL = [[UILabel alloc] init];
    codeL.frame = CGRectMake(phoneL.left, lineV.bottom, phoneL.width, height);
    codeL.font = kFont(15);
    codeL.textAlignment = 0;
    codeL.text = @"验证码";
    codeL.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeL];
    UITextField *codeTF = [[UITextField alloc] init];
    self.codeTF = codeTF;
    codeTF.frame = CGRectMake(phoneTF.left, codeL.top, kScreenWidth, height);
    codeTF.placeholder = @"请输入验证码";
    codeTF.keyboardType = UIKeyboardTypePhonePad;
    codeTF.font = kFont(15);
    codeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeTF];
    
    //
    UIView *lineV2 = [[UIView alloc] init];
    lineV2.backgroundColor = kBgColor;
    lineV2.frame = CGRectMake(0, codeL.bottom +1, kScreenWidth, 1);
    [self.view addSubview:lineV2];
    lineV.hidden = YES;
    
    // ------ 图片验证码
    UITextField *pictureTF = [[UITextField alloc] init];
    pictureTF.frame = CGRectMake(codeL.left, lineV2.bottom, kScreenWidth, height);
    pictureTF.placeholder = @"请输入图形验证码";
    pictureTF.font = kFont(15);
    pictureTF.hidden = YES;
    pictureTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pictureTF];
    
    // ------ 登录
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat loginBtnY = pictureTF.hidden ? (codeL.bottom +50 *kScale):(pictureTF.bottom +50*kScale);
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
            [self showHint:@"获取验证码成功！"];
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
            [self showHint:@"登录成功！"];
            
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
