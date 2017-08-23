//
//  SelectedGiftsTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "SelectedGiftsTableViewCell.h"

@implementation SelectedGiftsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)delOnclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(delNumberOnclick:)]) {
        
        [_delegate delNumberOnclick:self.tag];
    }
}

- (IBAction)addOnclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(addNumberOnclick:)]) {
        
        [_delegate addNumberOnclick:self.tag];
    }
}

- (IBAction)customizeOnclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(productNumberOnclick:)]) {
        
        [_delegate productNumberOnclick:self.tag];
    }
}

@end
