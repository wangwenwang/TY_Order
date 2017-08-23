//
//  CheckOrderTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/9/28.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface CheckOrderTableViewCell : UITableViewCell

@property (strong, nonatomic) OrderModel *order;

/// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
