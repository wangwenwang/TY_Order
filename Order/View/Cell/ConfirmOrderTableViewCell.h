//
//  ConfirmOrderTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/21.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmOrderTableViewCellDelegate <NSObject>

/// 现价减少0.1
- (void)delOnclickOfConfirmOrderTableViewCell:(NSInteger)indexRow;

/// 现价增加0.1
- (void)addOnclickOfConfirmOrderTableViewCell:(NSInteger)indexRow;

/// 自定义价格
- (void)customizePriceOfConfirmOrderTableViewCell:(NSInteger)indexRow;

@end

@interface ConfirmOrderTableViewCell : UITableViewCell

@property (assign, nonatomic) id<ConfirmOrderTableViewCellDelegate> delegate;

/// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/// 策略名称
@property (weak, nonatomic) IBOutlet UILabel *promotionNameLabel;

/// 产品原价
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;

/// 产品现价
@property (weak, nonatomic) IBOutlet UIButton *nowPriceButton;

/// 产品数量
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

/// 增加价格
@property (weak, nonatomic) IBOutlet UIButton *delButton;

/// 降低价格
@property (weak, nonatomic) IBOutlet UIButton *addButton;

/// 减少按钮的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *delButtonWidth;

/// 增加按钮的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addButtonWidth;

///// 减少0.1元
//- (IBAction)delOnclick:(UIButton *)sender;
//
///// 增加0.1元
//- (IBAction)addOnclick:(UIButton *)sender;

@end
