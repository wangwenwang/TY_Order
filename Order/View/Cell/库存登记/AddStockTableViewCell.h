//
//  AddStockTableViewCell.h
//  Order
//
//  Created by 凯东源 on 17/6/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@protocol AddStockTableViewCellDelegate <NSObject>

@optional
- (void)PRODUCTION_DATE_onclick:(NSUInteger)index_in_all andIndex_in_paty:(NSUInteger)index_in_paty;

- (void)reloadData_LM;

@end

@interface AddStockTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AddStockTableViewCellDelegate> delegate;


@property (strong, nonatomic) ProductModel *productM;

/// 库存数量 生产日期 列表
@property (strong, nonatomic) NSMutableArray *products_cell_paty;

@end
