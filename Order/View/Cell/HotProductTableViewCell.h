//
//  HotProductTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotProductTableViewCell : UITableViewCell

/// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/// 产品规格
@property (weak, nonatomic) IBOutlet UILabel *formatLabel;

/// 产品价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/// 产品图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@end
