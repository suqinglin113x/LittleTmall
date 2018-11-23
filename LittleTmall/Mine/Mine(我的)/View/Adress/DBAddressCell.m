//
//  DBAddressCell.m
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import "DBAddressCell.h"
#import "DBAddressModel.h"

#define margin 10 *kScale

@interface DBAddressCell ()
@property (nonatomic, strong) UILabel *userNameL;
@property (nonatomic, strong) UILabel *phoneNumL;
@property (nonatomic, strong) UILabel *addressL;
@property (nonatomic, strong) UILabel *tagL;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation DBAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createAddressSubviews];
    }
    return self;
}
- (void)createAddressSubviews
{
    self.userNameL = [[UILabel alloc] init];
    [self.contentView addSubview:self.userNameL];
    self.userNameL.font = kFont(15);
    self.userNameL.textAlignment = 0;
    self.userNameL.textColor = [UIColor blackColor];
    
    self.phoneNumL = [[UILabel alloc] init];
    [self.contentView addSubview:self.phoneNumL];
    self.phoneNumL.font = kFont(15);
    self.phoneNumL.textAlignment = 0;
    self.phoneNumL.textColor = [UIColor blackColor];
    
    self.addressL = [[UILabel alloc] init];
    [self.contentView addSubview:self.addressL];
    self.addressL.font = kFont(14);
    self.addressL.textAlignment = 0;
    self.addressL.numberOfLines = 3;
    self.addressL.textColor = [UIColor blackColor];
    
    self.deleteBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn setImage:[UIImage imageNamed:@"address_delete"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tagL = [[UILabel alloc] init];
    [self.contentView addSubview:self.tagL];
    self.tagL.font = kFont(11);
    self.tagL.textAlignment = 1;
    self.tagL.text = @"默认";
    self.tagL.hidden = YES;
    self.tagL.textColor = kMainColor;
    self.tagL.layer.borderWidth = 1;
    self.tagL.layer.borderColor = kMainColor.CGColor;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.userNameL.frame = CGRectMake(margin, margin *0.6, 80 *kScale, 30 *kScale);
    self.phoneNumL.frame = CGRectMake(self.userNameL.right, self.userNameL.top, 150 *kScale, 30 *kScale);
    self.deleteBtn.frame = CGRectMake(self.contentView.width - 30 *kScale, 0, 20 *kScale, 40 *kScale);
    self.deleteBtn.centerY = self.contentView.centerY;
    self.addressL.frame = CGRectMake(self.phoneNumL.origin.x, self.phoneNumL.bottom - margin *0.8, 250 *kScale, 50 *kScale);
    self.tagL.frame = CGRectMake(self.userNameL.origin.x, self.userNameL.bottom, 30 *kScale, 15 *kScale);
    
}

- (void)setAddressModel:(DBAddressModel *)addressModel
{
    _addressModel = addressModel;
    self.userNameL.text = addressModel.userName;
    self.phoneNumL.text = addressModel.telNumber;
    self.addressL.text = addressModel.full_address;
    self.tagL.hidden = !addressModel.isDefault;

}

- (void)deleteBtnClick:(UIButton *)btn
{
    DBLog(@"点击删除操作");
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
