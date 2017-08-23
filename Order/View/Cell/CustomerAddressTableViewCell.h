//
//  CustomerAddressTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/13.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerAddressTableViewCell : UITableViewCell

/// 联系人名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/// 联系电话
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

/// 地址代码
@property (weak, nonatomic) IBOutlet UILabel *addressCodeLabel;

/// 地址详情
@property (weak, nonatomic) IBOutlet UILabel *addressDetailLabel;

@end
