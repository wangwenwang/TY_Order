//
//  ShoppingCartTableViewCell.h
//  Order
//
//  Created by 凯东源 on 16/10/17.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

/// 回调协议
@protocol ShoppingCartTableViewCellDelegate <NSObject>

@optional
- (void)delOnclickOfShoppingCartTableViewCell:(double)price andIndexRow:(int)indexRow;

@optional
- (void)addOnclickShoppingCartTableViewCell:(double)price andIndexRow:(int)indexRow;

@optional
- (void)noStockOfShoppingCartTableViewCell;

@end


@interface ShoppingCartTableViewCell : UITableViewCell

@property (weak, nonatomic) id<ShoppingCartTableViewCellDelegate> delegate;

/// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

/// 已选数量
@property (weak, nonatomic) IBOutlet UIButton *productNumberButton;

/// 产品模型
@property (strong, nonatomic) ProductModel *product;

@end
