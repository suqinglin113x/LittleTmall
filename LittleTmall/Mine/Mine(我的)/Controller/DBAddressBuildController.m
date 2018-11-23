//
//  DBAddressBuildController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBAddressBuildController.h"
#import "ZHFAddTitleAddressView.h"
#import "DBAddressModel.h"

@interface DBAddressBuildController ()<UITextFieldDelegate, ZHFAddTitleAddressViewDelegate>
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *phoneNumTF;
@property (nonatomic, strong) UITextField *addressTF;
@property (nonatomic, strong) UITextField *detailAddressTF;
@property (nonatomic, strong) UIButton *defaultBtn;
@property(nonatomic,strong)ZHFAddTitleAddressView * addTitleAddressView;
@property (nonatomic, strong) NSDictionary *addressInfo;
@end

@implementation DBAddressBuildController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地址编辑";
    
    [self createUI];
    
    // 地址选择器
    [self addAddressPickView];
}

- (void)addAddressPickView
{
    self.addTitleAddressView = [[ZHFAddTitleAddressView alloc]init];
    self.addTitleAddressView.title = @"选择地址";
    self.addTitleAddressView.userID = 7;
    self.addTitleAddressView.delegate1 = self;
    self.addTitleAddressView.defaultHeight = 400 *kScale;
    self.addTitleAddressView.titleScrollViewH = 37 *kScale;
    [self.view addSubview:[self.addTitleAddressView initAddressView]];
}

- (void)createUI
{
    CGFloat totalH = 0;
    NSArray *placeHolder = @[@"姓名", @"手机号码", @"省份、城市、区县", @"详细地址，如街道、楼盘号等"];
    for (NSInteger i = 0; i < placeHolder.count; i ++) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = placeHolder[i];
        textField.textColor = [UIColor blackColor];
        textField.backgroundColor = [UIColor whiteColor];
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
        if (i == 0) {// 姓名
            textField.text = self.addressModel? self.addressModel.userName : @"";
            self.userNameTF = textField;
        }
        if (i == 1) {// 手机号码
            textField.text = self.addressModel? self.addressModel.telNumber : @"";
            self.phoneNumTF = textField;
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        if (i == 2) {// 省份等
            textField.text = self.addressModel? self.addressModel.full_region : @"";
            self.addressTF = textField;
            [textField addTarget:self action:@selector(showAddressView) forControlEvents:UIControlEventTouchDown];
        }
        if (i == 3) {// 详细地址
            textField.text = self.addressModel? self.addressModel.detailInfo : @"";
            self.detailAddressTF = textField;
        }
        
        totalH += hei + 1;
    }
    
    UIButton *defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:defaultBtn];
    self.defaultBtn =  defaultBtn;
    defaultBtn.frame = CGRectMake(0, totalH + 20 *kScale, kScreenWidth *0.5, 50);
    defaultBtn.centerX = self.view.centerX;
    defaultBtn.selected = self.addressModel.isDefault;
    [defaultBtn setImage:[UIImage imageNamed:@"circle_nosel"] forState:UIControlStateNormal];
    [defaultBtn setImage:[UIImage imageNamed:@"circle_sel"] forState:UIControlStateSelected];
    [defaultBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    [defaultBtn.titleLabel setFont:kFont(15)];
    [defaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(setDefaultAddress:) forControlEvents:UIControlEventTouchUpInside];

    [self bottomView];
}

- (void)bottomView
{
    CGFloat Height = 50 *kScale;
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatusBarHeight - Height, kScreenWidth*0.5, Height);
    [cancelbtn addTarget:self action:@selector(cancleBuild) forControlEvents:UIControlEventTouchUpInside];
    [cancelbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn.titleLabel  setFont:kFont(15)];
    cancelbtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:cancelbtn];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(kScreenWidth *0.5, cancelbtn.origin.y, kScreenWidth *0.5, Height);
    [saveBtn addTarget:self action:@selector(saveBuild) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn.titleLabel  setFont:kFont(15)];
    saveBtn.backgroundColor = kMainColor;
    [self.view addSubview:saveBtn];
}
#pragma mark -- action --
- (void)showAddressView
{
    [self.view endEditing:YES];
    [self.addTitleAddressView addAnimate];
}
-  (void)setDefaultAddress:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.defaultBtn.selected = btn.selected;
}

- (void)cancleBuild
{
    
}

/**
 保存地址
 */
- (void)saveBuild
{
    if ([self.userNameTF.text isNilOrBlank]) {
        [self showHint:@"请输入非空格姓名"];
        return;
    } else if ([self.phoneNumTF.text isNilOrBlank]|| ![self.phoneNumTF.text isMobilePhone]) {
        [self showHint:@"请检查手机号是否正确"];
        return;
    } else if (self.addressTF.text.length == 0 || !self.addressTF.text) {
        [self showHint:@"请选择地址"];
        return;
    } else if ([self.detailAddressTF.text isNilOrBlank]) {
        [self showHint:@"请填写更加详细的地址"];
        return;
    } else {
        DBAddressModel *model = [DBAddressModel new];
        model.userName = self.userNameTF.text;
        model.telNumber = self.phoneNumTF.text;
        model.full_address = [self.addressTF.text stringByAppendingString:self.detailAddressTF.text];
        model.isDefault = self.defaultBtn.selected;
        // 回调
//        if (self.saveAddressBlock) {
//            self.saveAddressBlock(model);
//        }
        NSDictionary *dict = @{
                               
                               };
        [BaseNetTool SaveAddressParams:dict block:^(DBAddressModel *model, NSError *error) {
            
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}

-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID{
    NSString *title = [titleAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.addressTF.text = !title.length?self.addressTF.text:titleAddress;
    NSLog( @"%@", [NSString stringWithFormat:@"打印的对应省市县的id=%@",titleAddress]);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2) {
        return NO;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.userNameTF) {
        self.userNameTF.text = textField.text;
    } else if (textField == self.phoneNumTF) {
        self.phoneNumTF.text = textField.text;
    } else if (textField == self.addressTF) {
        self.addressTF.text = textField.text;
    } else {
        self.detailAddressTF.text = textField.text;
    }
}

@end
