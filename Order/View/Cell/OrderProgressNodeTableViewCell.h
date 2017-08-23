//
//  OrderProgressNodeTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/12.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderProgressNodeTableViewCell : UITableViewCell

/// 订单状态跟踪
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

/// 订单时间跟踪
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
