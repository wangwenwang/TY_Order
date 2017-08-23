//
//  GetAppBillFeeListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppBillFeeListTableViewCell.h"

@interface GetAppBillFeeListTableViewCell ()

// 企业ID号
@property (weak, nonatomic) IBOutlet UILabel *ENT_IDX;

// 账单名称
@property (weak, nonatomic) IBOutlet UILabel *BILL_NAME;

// 账单月份
@property (weak, nonatomic) IBOutlet UILabel *BILL_DATE;

@end

@implementation GetAppBillFeeListTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setAppBillFeeM:(AppBillFeeModel *)appBillFeeM {
    
    _appBillFeeM = appBillFeeM;
    
    _ENT_IDX.text = _appBillFeeM.eNTIDX;
    
    _BILL_NAME.text = _appBillFeeM.bILLNAME;
    
    _BILL_DATE.text = _appBillFeeM.bILLDATE;
}

@end
