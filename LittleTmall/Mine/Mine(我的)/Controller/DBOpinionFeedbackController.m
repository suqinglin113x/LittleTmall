//
//  DBOpinionFeedbackController.m
//  LittleTmall
//
//  Created by Adam on 2018/11/22.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBOpinionFeedbackController.h"
#import "NSString+DBTool.h"
#import "ZJPickerView.h"
#import "DBTextView.h"

@interface DBOpinionFeedbackController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, copy) NSString *phoneStr;
@property (nonatomic, copy) NSString *textViewStrLabel;
@property (nonatomic, copy) NSString *feedbacktype;
@property  (nonatomic, strong) UILabel *topLeftType;
@property (nonatomic, strong) DBTextView *textview;
@property (nonatomic, strong) UITextField *connectTextField;
@property (nonatomic, strong) UIView *topview;
@end

@implementation DBOpinionFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"意见反馈";
   //初始化子view
    [self setSubviews];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    DBLog(@"********%@",self.topview);
}
- (void)loadData{
    DBWeakSelf
    NSDictionary *dict = @{@"mobile":self.phoneStr,
                           @"index":self.feedbacktype,
                           @"content":self.textViewStrLabel
                           };
    [BaseNetTool OpinionFeedbackParams:dict block:^(id response, NSError *error) {
        if (response) {
            [MBProgressHUD showSuccess:response];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf .navigationController popViewControllerAnimated:YES];
            });
        }
        if (error) {
            [MBProgressHUD showError:@"提交失败"];
        }
        
    }];
    
}
- (void)setSubviews{
    UIView *topview = [[UIView alloc] init];
    topview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topview];
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(12);
    }];
    self.topview = topview;
   //[topview.superview layoutIfNeeded];
    DBLog(@"frame%@",topview);
    
    UILabel *topLeftType = [[UILabel alloc] init];
    topLeftType.text = @"请选择反馈类型";
    topLeftType.font = kFont(15);
    topLeftType.textColor = kTextColor;
    [topview addSubview:topLeftType];
    self.topLeftType = topLeftType;
    [topLeftType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerY.equalTo(topview.mas_centerY);
    }];
    
    
    UIImageView *upImageview = [[UIImageView alloc] init];
    upImageview.contentMode = UIViewContentModeScaleAspectFit;
    upImageview.userInteractionEnabled = YES;
    upImageview.image = [UIImage imageNamed:@"xiala"];
    [topview addSubview:upImageview];
    [upImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topview.mas_right).offset(-10);
        make.centerY.equalTo(topview.mas_centerY);
        make.height.and.width.mas_equalTo(15);
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [topview addGestureRecognizer:tap];

    DBTextView *textView = [[DBTextView alloc] initWithFrame:CGRectMake(0, 72, kScreenWidth, 187)];
    textView.placeholderColor = UIColorFromHex(0xbbbbbb);
    textView.textColor = kTextColor;
    textView.textFont = kFont(15);
    textView.textMaxNum = 500;
    textView.maxNumColor = UIColorFromHex(0x999999);
    textView.leftAndRightSpace = 18;
    textView.borderLineColor = [UIColor  whiteColor];
    [self.view addSubview:textView];
    self.textview = textView;
    __weak typeof(self) weakself = self;
    textView.textViewListening = ^(NSString *textViewStr) {
       // NSLog(@"tv监听输入的内容：%@",textViewStr);
        weakself.textViewStrLabel = textViewStr;
    };

    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = kFont(13);
    phoneLabel.textColor = kTextColor;
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(textView.mas_bottom).offset(8);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(phoneLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(50);
    }];
    
    UITextField *connectTextField = [[UITextField alloc] init];
    connectTextField.placeholder = @"方便我们与你联系";
    connectTextField.font = kFont(13);
    connectTextField.keyboardType = UIKeyboardTypeNumberPad;
    connectTextField.delegate = self;
    connectTextField.textColor = kTextColor;
    [bottomView addSubview:connectTextField];
    self.connectTextField = connectTextField;
    [connectTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(18);
        //make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right).offset(-18);
        make.top.equalTo(bottomView.mas_top);
        make.bottom.equalTo(bottomView.mas_bottom);
        
    }];
    
    UIButton *bottomBtn = [[UIButton alloc] init];
    [bottomBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    bottomBtn.titleLabel.font = kFont(15);
    bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomBtn az_setGradientBackgroundWithColors:@[kMainBeginColor, kMainEndColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [bottomBtn addTarget:self action:@selector(submitAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(50);
    }];
}

- (void)tapAction{
    [self.textview resignFirstResponder];
    [self.connectTextField resignFirstResponder];
    [self.view endEditing:YES];
    
    NSDictionary *dict = @{ ZJPickerViewPropertyIsTouchBackgroundHideKey : @YES,
                             ZJPickerViewPropertyIsShowSelectContentKey : @YES,
                             ZJPickerViewPropertyIsScrollToSelectedRowKey: @YES,
                             ZJPickerViewPropertyIsAnimationShowKey : @YES};
    __weak typeof(self) weakself = self;
    NSArray *arr = @[@"商品相关", @"物流状况", @"客户服务", @"优惠活动", @"功能异常", @"产品建议", @"其他"];
    [ZJPickerView zj_showWithDataList:arr propertyDict:dict completion:^(NSString *selectContent) {
        DBLog(@"ZJPickerView log tip：---> selectContent:%@", selectContent);
        weakself.feedbacktype = [NSString stringWithFormat:@"%ld",[arr indexOfObject:selectContent] + 1];
        weakself.topLeftType.text = selectContent;
        
    }];

}

- (void)submitAction:(UIButton *)btn{
    
    if ([DBTool isNUllOrIsEmptyWith:self.feedbacktype]) {
        [MBProgressHUD showError:@"请选择反馈类型"];
        return;
    }
    
    if ([DBTool isNUllOrIsEmptyWith:self.textViewStrLabel]) {
        [MBProgressHUD showError:@"请填写反馈意见"];
        return;
    }
    if ([DBTool isNUllOrIsEmptyWith:self.phoneStr]) {
        [MBProgressHUD showError:QZPhoneNumIsEmpty];
        return;
    }
    
    if (![self.phoneStr isMobilePhone]) {
        [MBProgressHUD showError:QZPhoneNumInputError];
        return;
    }
    [self loadData];
    
}
#pragma makk --- UITextFieldExtensionDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 11) {
        return NO;
    }
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.phoneStr = text;
   // DBLog(@"%@",text);
    return YES;
    
}
@end
