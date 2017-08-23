//
//  ShoppingCartTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/10/17.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)delOnlick:(UIButton *)sender {
    if(_product.CHOICED_SIZE > 0) {
        _product.CHOICED_SIZE --;
        NSString *productNumberStr = [NSString stringWithFormat:@"%lld", _product.CHOICED_SIZE];
        
        [_productNumberButton setTitle:productNumberStr forState:UIControlStateNormal];
        if([_delegate respondsToSelector:@selector(delOnclickOfShoppingCartTableViewCell:andIndexRow:)]) {
            [_delegate delOnclickOfShoppingCartTableViewCell:_product.PRODUCT_PRICE andIndexRow:(int)self.tag];
        }
    }
}

- (IBAction)addOnclick:(UIButton *)sender {
    if([_product.ISINVENTORY isEqualToString:@"Y"]) {
        
        long long maxSize = _product.PRODUCT_INVENTORY;
        if(_product.CHOICED_SIZE < maxSize) {
            [self add];
        } else {
            if([_delegate respondsToSelector:@selector(noStockOfShoppingCartTableViewCell)]) {
                [_delegate noStockOfShoppingCartTableViewCell];
            }
        }
    } else {
        [self add];
    }
}

- (void)add {
    _product.CHOICED_SIZE ++;
    NSString *productNumberStr = [NSString stringWithFormat:@"%lld", _product.CHOICED_SIZE];
    
    [_productNumberButton setTitle:productNumberStr forState:UIControlStateNormal];
    if([_delegate respondsToSelector:@selector(addOnclickShoppingCartTableViewCell:andIndexRow:)]) {
        [_delegate addOnclickShoppingCartTableViewCell:_product.PRODUCT_PRICE andIndexRow:(int)self.tag];
    }
}

@end
