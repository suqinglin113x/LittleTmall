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
@property (nonatomic, copy) NSString *textViewStrLabel;;
@end

@implementation DBOpinionFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"意见反馈";
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(RightBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    //[informationCardBtn setImage:[UIImage imageNamed:@"nav_information"] forState:UIControlStateNormal];
    [informationCardBtn setTitle:@"diyi" forState:UIControlStateNormal];
    
    [informationCardBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn addTarget:self action:@selector(RightnextCLick:) forControlEvents:UIControlEventTouchUpInside];
    //[settingBtn setImage:[UIImage imageNamed:@"nav_settings"] forState:UIControlStateNormal];
    [settingBtn setTitle:@"dierge" forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
    self.navigationItem.rightBarButtonItems  = @[informationCardItem,settingBtnItem];

    // 类型选择器
    [self setSubviews];
    
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
    
    UILabel *topLeftType = [[UILabel alloc] init];
    topLeftType.text = @"请选择反馈类型";
    topLeftType.font = kFont(12);
    topLeftType.textColor = kTextColor;
    [topview addSubview:topLeftType];
    [topLeftType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerY.equalTo(topview.mas_centerY);
    }];
    
    
    UIImageView *upImageview = [[UIImageView alloc] init];
    //upImageview.backgroundColor = [UIColor redColor];
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
    [upImageview addGestureRecognizer:tap];
    
    DBTextView *textView = [[DBTextView alloc] initWithFrame:CGRectMake(0, 72, kScreenWidth, 187)];
    textView.placeholderColor = kTextColor;
    textView.textColor = kTextColor;
    textView.textFont = kFont(12);
    textView.textMaxNum = 500;
    textView.leftAndRightSpace = 18;
    textView.borderLineColor = [UIColor  whiteColor];
    [self.view addSubview:textView];
    __weak typeof(self) weakself = self;
    textView.textViewListening = ^(NSString *textViewStr) {
        NSLog(@"tv监听输入的内容：%@",textViewStr);
        weakself.textViewStrLabel = textViewStr;
        
    };

    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = kFont(10);
    phoneLabel.textColor = UIColorFromHex(0xCACACA);
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
    connectTextField.font = kFont(10);
    connectTextField.keyboardType = UIKeyboardTypeNumberPad;
    connectTextField.delegate = self;
    connectTextField.textColor = UIColorFromHex(0x7c7c7c);
    [bottomView addSubview:connectTextField];
    [connectTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(18);
        //make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right).offset(-18);
        make.top.equalTo(bottomView.mas_top);
        make.bottom.equalTo(bottomView.mas_bottom);
        
    }];
    
   
    
    UIButton *bottomBtn = [[UIButton alloc] init];
    [bottomBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    bottomBtn.titleLabel.font = kFont(12);
    bottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    bottomBtn.backgroundColor =UIColorFromHex(0xB4302D);
    [bottomBtn addTarget:self action:@selector(submitAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    
}
- (void)RightBtnCLick:(UIButton *)btn{
    DBLog(@"dierge");
}
- (void)RightnextCLick:(UIButton *)btn{
    DBLog(@"diyige");
}
- (void)tapAction{
    NSDictionary *dict = @{ ZJPickerViewPropertyIsTouchBackgroundHideKey : @YES,
                             ZJPickerViewPropertyIsShowSelectContentKey : @YES,
                             ZJPickerViewPropertyIsScrollToSelectedRowKey: @YES,
                             ZJPickerViewPropertyIsAnimationShowKey : @YES};
    [ZJPickerView zj_showWithDataList:@[@"IT", @"销售", @"自媒体", @"游戏主播", @"产品策划"] propertyDict:dict completion:^(NSString *selectContent) {
        DBLog(@"ZJPickerView log tip：---> selectContent:%@", selectContent);
    }];

}

- (void)submitAction:(UIButton *)btn{
    DBLog(@"提交");
    if ([DBTool isNUllOrIsEmptyWith:self.phoneStr]) {
        [MBProgressHUD showError:QZPhoneNumIsEmpty];
        return;
    }
    
    if (![self.phoneStr isMobilePhone]) {
        [MBProgressHUD showError:QZPhoneNumInputError];
        return;
    }
    
    if ([DBTool isNUllOrIsEmptyWith:self.textViewStrLabel]) {
        [MBProgressHUD showError:@"请写意见"];
    }
    
    
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
    DBLog(@"%@",text);
    return YES;
    
}
@end
