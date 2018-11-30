//
//  DBLoginViewController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/23.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBLoginViewController.h"
#import "YYText.h"

@interface DBLoginViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UITextField *pictureTF;
@property (nonatomic, strong) UIButton *getSMSBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UIImageView *codeIV;
@end

@implementation DBLoginViewController
{
    
    NSInteger time;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录斗宝";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTopSubviews];
}

- (void)createTopSubviews
{
    
    CGFloat height = 52*kScale;
    CGFloat leftMargin = 20 *kScale;
    
    UIImageView *logoIV = [[UIImageView alloc] init];
    logoIV.frame = CGRectMake(0, 30 *kScale, 80 *kScale, 80 *kScale);
    logoIV.centerX = self.view.centerX;
    logoIV.layer.cornerRadius = 10 *kScale;
    logoIV.layer.masksToBounds = YES;
    logoIV.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoIV];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.frame = CGRectMake(0, logoIV.bottom + 5*kScale, logoIV.width, 30 *kScale);
    titleL.centerX = logoIV.centerX;
    titleL.textAlignment = 1;
    titleL.text = @"斗宝商城";
    titleL.textColor = UIColorFromHex(0x333333);
    titleL.font = [UIFont systemFontOfSize:18 *kScale weight:UIFontWeightSemibold];
    [self.view addSubview:titleL];
    
    //
    UILabel *tipL = [[UILabel alloc] init];
    tipL.frame = CGRectMake(leftMargin, titleL.bottom + 30 *kScale, 100*kScale, 30 *kScale);
    tipL.font = kFont(16);
    tipL.textAlignment = 0;
    tipL.text = @"快速登录";
    [self.view addSubview:tipL];
    
    NSArray *titleS = @[@"手机号码",@"验证码", @"图片验证码"];
    NSArray *placeholderS = @[@"请输入手机号码",@"请输入验证码", @"请输入图形验证码"];
    for (int i = 0; i <titleS.count; i ++) {
        //
        UIView *lineV = [[UIView alloc] init];
        lineV.backgroundColor = UIColorFromHex(0xE8E8E8);
        lineV.frame = CGRectMake(0, tipL.bottom +18*kScale + (height + 1 *kScale)*i, kScreenWidth, 1*kScale);
        [self.view addSubview:lineV];
        
        UIView *itemView = [[UIView alloc] init];
        itemView.frame = CGRectMake(0, lineV.bottom , kScreenWidth, height);
        [self.view addSubview:itemView];
        // ----- 手机号码
        UILabel *titleL = [[UILabel alloc] init];
        titleL.frame = CGRectMake(leftMargin, 0, 80*kScale, height);
        titleL.font = kFont(16);
        titleL.textAlignment = 0;
        titleL.text = titleS[i];
        [itemView addSubview:titleL];
        UITextField *TF = [[UITextField alloc] init];
        TF.frame = CGRectMake(titleL.right, titleL.top, kScreenWidth-titleL.right, height);
        TF.placeholder = placeholderS[i];
        TF.font = kFont(16);
        TF.keyboardType = UIKeyboardTypePhonePad;
        TF.backgroundColor = [UIColor whiteColor];
        [itemView addSubview:TF];
        if (i == 1) {
            self.phoneTF = TF;
            UIButton *getSMSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.getSMSBtn = getSMSBtn;
            getSMSBtn.frame = CGRectMake(kScreenWidth - 80*kScale - leftMargin, 0, 80*kScale, 30*kScale);
            getSMSBtn.centerY = TF.centerY;
            [getSMSBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [getSMSBtn setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
            [getSMSBtn.titleLabel setFont:kFont(14)];
            [getSMSBtn addTarget:self action:@selector(getSMSBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [itemView addSubview:getSMSBtn];
        }
        
        if (i == 1) {
            self.codeTF = TF;
        }
        if (i == 2) {
            // 隐藏
            titleL.hidden = YES;
            TF.left = leftMargin;
            self.pictureTF = TF;
            // 添加图片码
            UIImageView *codeIV = [[UIImageView alloc] init];
            codeIV.frame = CGRectMake(kScreenWidth - leftMargin- 70*kScale, 0, 70 *kScale, 30*kScale);
            codeIV.centerY = TF.centerY;
            codeIV.backgroundColor = [UIColor orangeColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getImageCode)];
            [codeIV addGestureRecognizer:tap];
            [itemView addSubview:codeIV];
            // 黑线
            UIView *lineV = [[UIView alloc] init];
            lineV.backgroundColor = UIColorFromHex(0xE8E8E8);
            CGPoint point = [self.pictureTF convertPoint:self.pictureTF.origin toView:self.view];
            lineV.frame = CGRectMake(0, point.y +height, kScreenWidth, 1*kScale);
            [self.view addSubview:lineV];
           lineV.hidden = self.pictureTF.hidden = itemView.hidden = NO;
        }
    }
    
    CGFloat totalHeight = 0;
    UITextField *lastTF = (self.pictureTF.hidden ? self.codeTF : self.pictureTF);
    CGPoint point = [lastTF convertPoint:self.pictureTF.origin toView:self.view];
    totalHeight = point.y +height;
    
    // ------- 协议条款
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtn = chooseBtn;
    [self.view addSubview:chooseBtn];
    chooseBtn.frame = CGRectMake(leftMargin, totalHeight + 20 *kScale, 15*kScale, 15*kScale);
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"CellButton"] forState:UIControlStateNormal];
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"CellButtonSelected"] forState:UIControlStateSelected];
    [chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    YYLabel *protocolL = [[YYLabel alloc] init];
    [self.view addSubview:protocolL];
    protocolL.frame = CGRectMake(chooseBtn.right + 5*kScale, 0, 300 *kScale, 30 *kScale);
    protocolL.centerY = chooseBtn.centerY;
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"已阅读并同意《平台服务协议》"];
    text.yy_lineSpacing = 5;
    text.yy_font = [UIFont systemFontOfSize:14];
    text.yy_color = [UIColor blackColor];
    [text yy_setTextHighlightRange:NSMakeRange(6, text.length - 6) color:kMainColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"xxx协议被点击了");
    }];
    protocolL.numberOfLines = 0;  //设置多行显示
    protocolL.preferredMaxLayoutWidth = kScreenWidth - 30; //设置最大的宽度
    protocolL.attributedText = text;  //设置富文本

    // ------ 登录
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat loginBtnY = self.chooseBtn.bottom +30 *kScale;
    loginBtn.layer.cornerRadius = 5 *kScale;
    loginBtn.frame = CGRectMake(20*kScale, loginBtnY, kScreenWidth - 40*kScale, 50*kScale);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn az_setGradientBackgroundWithColors:@[kMainBeginColor, kMainEndColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [loginBtn.titleLabel setFont:kFont(17)];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

#pragma mark -- action
/** 获取短信验证码*/
- (void)getSMSBtnClick
{
    [self.view endEditing:YES];
    if (self.phoneTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    time = 60;
    NSDictionary *dict = @{@"mobile":self.phoneTF.text};
    [BaseNetTool GetSMSWithParams:dict block:^(id response, NSError *error) {
        if (response) {
            [MBProgressHUD showSuccess:@"获取验证码成功！"];
            [self startDownTimer];
        }
    }];
}

/** */
- (void)chooseBtnClick:(UIButton *)btn
{
    btn.selected =! btn.selected;
}

/** 登录*/
-  (void)loginBtnClick
{
    [self.view endEditing:YES];
    if (self.phoneTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.codeTF.text.length == 0){
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
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

/** 获取图片验证码*/
- (void)getImageCode
{
    DBLog(@"获取图片验证码");
    
}

/** 倒计时*/
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
