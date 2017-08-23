//
//  OrderTmsDetailsTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/11.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTmsDetailsTableViewCell : UITableViewCell

/// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

/// 产品编号
@property (weak, nonatomic) IBOutlet UILabel *productNoLabel;

/// 产品总量
@property (weak, nonatomic) IBOutlet UILabel *productQtyLabel;

/// 产品总重
@property (weak, nonatomic) IBOutlet UILabel *productWeightLabel;

/// 产品体积
@property (weak, nonatomic) IBOutlet UILabel *productVolLabel;

@end
