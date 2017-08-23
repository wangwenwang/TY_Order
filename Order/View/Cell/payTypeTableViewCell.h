//
//  payTypeTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/19.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payTypeTableViewCell : UITableViewCell

/// 支付方式
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;

/// 已选择的勾选状态
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end
