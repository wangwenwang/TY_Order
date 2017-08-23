//
//  AddressListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/7/5.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "AddressListTableViewCell.h"

@interface AddressListTableViewCell ()

// 联系人
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_PERSON;

// 联系方式
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_TEL;

// 详细地址
@property (weak, nonatomic) IBOutlet UILabel *ADDRESS_INFO;

// 默认地址
@property (weak, nonatomic) IBOutlet UIImageView *iconImagView;

@end

@implementation AddressListTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setAddressM:(AddressModel *)addressM {

    _addressM = addressM;

    _CONTACT_PERSON.text = _addressM.CONTACT_PERSON;

    _CONTACT_TEL.text = _addressM.CONTACT_TEL;

    _ADDRESS_INFO.text = [NSString stringWithFormat:@"%@%@", _addressM.ADDRESS_REGION, _addressM.ADDRESS_INFO];
    
    _iconImagView.image = [UIImage imageNamed:_addressM.defaultAddress ? @"lm_address_selected" : @"lm_address_unselect"];
}


- (IBAction)editOnclick {

    if([_delegate respondsToSelector:@selector(editOnclick:)]) {

        [_delegate editOnclick:self.tag];
    }
}


- (IBAction)defauleAddressOnclick {
    
    if([_delegate respondsToSelector:@selector(defauleAddressOnclick:)]) {
        
        [_delegate defauleAddressOnclick:self.tag];
    }
}


- (IBAction)deleteOnclick {
    
    if([_delegate respondsToSelector:@selector(deleteOnclick:)]) {
        
        [_delegate deleteOnclick:self.tag];
    }
}

@end
