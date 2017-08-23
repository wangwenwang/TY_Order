//
//  AddGiftProductsTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "AddGiftProductsTableViewCell.h"

@implementation AddGiftProductsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//减数量
- (IBAction)delOnclick:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(delNumberOnclick:)]) {
        [_delegate delNumberOnclick:self.tag];
    }
}

//加数量
- (IBAction)addOnclick:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(addNumberOnclick:)]) {
        [_delegate addNumberOnclick:self.tag];
    }
}

//自定义数量
- (IBAction)customizeOnclick:(UIButton *)sender {
    if([_delegate respondsToSelector:@selector(productNumberOnclick:)]) {
        [_delegate productNumberOnclick:self.tag];
    }
}

@end
