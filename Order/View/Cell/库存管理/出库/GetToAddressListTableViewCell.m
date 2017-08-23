//
//  GetToAddressListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetToAddressListTableViewCell.h"


@interface GetToAddressListTableViewCell ()

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

// 客户地址
@property (weak, nonatomic) IBOutlet UILabel *ADDRESS_INFO;

@end

@implementation GetToAddressListTableViewCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setGetToAddressM:(GetToAddressModel *)getToAddressM {
    
    _PARTY_NAME.text = getToAddressM.pARTYNAME;
    _ADDRESS_INFO.text = getToAddressM.aDDRESSINFO;
}

@end
