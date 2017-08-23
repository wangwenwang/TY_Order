//
//  MakeOrderTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/12.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeOrderTableViewCell : UITableViewCell

/// 客户类型
@property (weak, nonatomic) IBOutlet UILabel *customerTypeLabel;

/// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *customerCodeLabel;

/// 客户城市
@property (weak, nonatomic) IBOutlet UILabel *customerCityLabel;

/// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;

@end
