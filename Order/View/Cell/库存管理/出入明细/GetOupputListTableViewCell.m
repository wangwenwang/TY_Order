//
//  GetOupputListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputListTableViewCell.h"

@interface GetOupputListTableViewCell ()

// 出库单号
@property (weak, nonatomic) IBOutlet UILabel *OUTPUT_NO;

// 制单时间
@property (weak, nonatomic) IBOutlet UILabel *ADD_DATE;

@end

@implementation GetOupputListTableViewCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


- (void)setGetOupputM:(GetOupputModel *)getOupputM {
    
    _OUTPUT_NO.text = getOupputM.oUTPUTNO;
    _ADD_DATE.text = getOupputM.aDDDATE;
}

@end
