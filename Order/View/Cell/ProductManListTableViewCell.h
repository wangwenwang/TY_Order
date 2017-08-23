//
//  ProductManListTableViewCell.h
//  Order
//
//  Created by 凯东源 on 17/6/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@protocol ProductManListTableViewCellDelegate <NSObject>

@optional
- (void)PRODUCT_INVENTORY_NumberOnclick:(long long)number andIndexRow:(NSUInteger)indexRow;

@end

@interface ProductManListTableViewCell : UITableViewCell

@property (weak, nonatomic) id<ProductManListTableViewCellDelegate> delegate;


@property (strong, nonatomic) ProductModel *productM;

@end
