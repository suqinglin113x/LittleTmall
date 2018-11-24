//
//  DBAddressCell.h
//  LittleTmall
//
//  Created by Adam on 2018/11/21.
//  Copyright © 2018年 com.qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DBAddressCellDelegate <NSObject>
- (void)deleAddress:(DBAddressModel *)model;
@end
@interface DBAddressCell : UITableViewCell
@property (nonatomic, weak) id <DBAddressCellDelegate> delegate;
@property (nonatomic, strong) DBAddressModel *addressModel;
@end
