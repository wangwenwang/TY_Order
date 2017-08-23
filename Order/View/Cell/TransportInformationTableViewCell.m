//
//  TransportInformationTableViewCell.m
//  Order
//
//  Created by 凯东源 on 16/10/11.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "TransportInformationTableViewCell.h"

@interface TransportInformationTableViewCell ()

/// 查看进度
- (IBAction)checkProcessOnclick:(UIButton *)sender;

/// 查看路线
- (IBAction)checkPathOnclick:(UIButton *)sender;

/// 查看签名
- (IBAction)checkSignatureOnclick:(UIButton *)sender;

@end


@implementation TransportInformationTableViewCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (IBAction)checkProcessOnclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(checkProcessOnclick:)]) {
        
        [_delegate checkProcessOnclick:(int)self.tag];
    }
}


- (IBAction)checkPathOnclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(checkPathOnclick:)]) {
        
        [_delegate checkPathOnclick:(int)self.tag];
    }
}


- (IBAction)checkSignatureOnclick:(UIButton *)sender {
    
    if([_delegate respondsToSelector:@selector(checkSingatureOnclick:)]) {
        
        [_delegate checkSingatureOnclick:(int)self.tag];
    }
}

@end
