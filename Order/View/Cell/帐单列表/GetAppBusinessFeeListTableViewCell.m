//
//  GetAppBusinessFeeListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/7/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBusinessFeeListTableViewCell.h"
#import "Tools.h"

@interface GetAppBusinessFeeListTableViewCell ()


// 费用名称
@property (weak, nonatomic) IBOutlet UILabel *FEE_NAME;

// 费用金额
@property (weak, nonatomic) IBOutlet UILabel *FEE_AMOUNT;

// 产生时间
@property (weak, nonatomic) IBOutlet UILabel *FEE_DATE;

// 费用名称提示
@property (weak, nonatomic) IBOutlet UILabel *feeNamePromptLabel;

// 费用名称提示距下
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feeName_bottom;

// 费用名称距右
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feeName_trailing;

@end

@implementation GetAppBusinessFeeListTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setListM:(AppBusinessFeeListModel *)listM {
    
    _listM = listM;
    
    _FEE_NAME.text = _listM.fEENAME;
    _FEE_AMOUNT.text = _listM.fEEAMOUNT;
    _FEE_DATE.text = _listM.fEEDATE;
}

@end
