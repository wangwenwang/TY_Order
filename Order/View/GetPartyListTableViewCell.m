//
//  GetPartyListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/7/13.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetPartyListTableViewCell.h"

@interface GetPartyListTableViewCell ()


/// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CODE;

/// 客户城市
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CITY;

/// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

@end

@implementation GetPartyListTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setPartyM:(PartyModel *)partyM {
    
    _partyM = partyM;
    
    _PARTY_CODE.text = _partyM.PARTY_CODE;
    
    _PARTY_CITY.text = _partyM.PARTY_CITY;
    
    _PARTY_NAME.text = _partyM.PARTY_NAME;
}


- (IBAction)deleteOnclick {
    
    if([_delegate respondsToSelector:@selector(deleteOnclick:)]) {
        
        [_delegate deleteOnclick:self.tag];
    }
}

@end
