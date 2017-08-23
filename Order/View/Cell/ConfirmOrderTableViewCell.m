//
//  ConfirmOrderTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/10/21.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ConfirmOrderTableViewCell.h"

@implementation ConfirmOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)delOnclick:(UIButton *)sender {
    
//    CGFloat price = [_nowPriceLabel.text floatValue];
//    price -= 0.1;
//    _nowPriceLabel.text = [NSString stringWithFormat:@"%.1f", price];
    if([_delegate respondsToSelector:@selector(delOnclickOfConfirmOrderTableViewCell:)]) {
        
        [_delegate delOnclickOfConfirmOrderTableViewCell:self.tag];
    }
}

- (IBAction)addOnclick:(UIButton *)sender {
    
//    CGFloat price = [_nowPriceLabel.text floatValue];
//    price += 0.1;
//    _nowPriceLabel.text = [NSString stringWithFormat:@"%.1f", price];
    if([_delegate respondsToSelector:@selector(addOnclickOfConfirmOrderTableViewCell:)]) {
        
        [_delegate addOnclickOfConfirmOrderTableViewCell:self.tag];
    }
}

- (IBAction)nowProductLabelOnclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(customizePriceOfConfirmOrderTableViewCell:)]) {
        
        [_delegate customizePriceOfConfirmOrderTableViewCell:self.tag];
    }
}

@end
