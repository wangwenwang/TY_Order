//
//  AddStockCellTableViewCell.h
//  Order
//
//  Created by 凯东源 on 17/6/9.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"

@protocol AddStockCellTableViewCellDelegate <NSObject>

@optional
- (void)PRODUCTION_DATE_onclick:(NSUInteger)indexRow;

@end

@interface AddStockCellTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AddStockCellTableViewCellDelegate> delegate;


@property (strong, nonatomic) NSMutableArray *products_cell_paty;

@end
