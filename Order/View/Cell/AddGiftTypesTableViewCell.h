//
//  AddGiftTypesTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGiftTypesTableViewCell : UITableViewCell

/// 系列名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/// 可选数量
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

/// 剩余数量
@property (weak, nonatomic) IBOutlet UILabel *laveLabel;

@end
