//
//  ConfirmOrderGiftsTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/26.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderGiftsTableViewCell : UITableViewCell

/// 产品图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

/// 名称1
@property (weak, nonatomic) IBOutlet UILabel *name1Label;

/// 名称2
@property (weak, nonatomic) IBOutlet UILabel *name2Label;

/// 原价
@property (weak, nonatomic) IBOutlet UILabel *orgPriceLabel;

/// 现价
@property (weak, nonatomic) IBOutlet UILabel *actPriceLabel;

/// 数量
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end
