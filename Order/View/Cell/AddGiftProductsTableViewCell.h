//
//  AddGiftProductsTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddGiftProductsTableViewCellDelegate <NSObject>

@optional
- (void)delNumberOnclick:(NSInteger)indexRow;

@optional
- (void)addNumberOnclick:(NSInteger)indexRow;

@optional
- (void)productNumberOnclick:(NSInteger)indexRow;

@end

@interface AddGiftProductsTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AddGiftProductsTableViewCellDelegate> delegate;

/// 产品图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

/// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/// 产品规格
@property (weak, nonatomic) IBOutlet UILabel *formLabel;

/// 产品数量
@property (weak, nonatomic) IBOutlet UIButton *numberLabel;

/// 剩余库存提示label
@property (weak, nonatomic) IBOutlet UILabel *stockPromptLabel;

/// 剩余库存
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@end
