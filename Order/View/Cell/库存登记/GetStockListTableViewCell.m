//
//  GetStockListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetStockListTableViewCell.h"
#import "Tools.h"

@interface GetStockListTableViewCell ()

// 客户代码
@property (weak, nonatomic) IBOutlet UILabel *PARTY_CODE;

// 客户名称
@property (weak, nonatomic) IBOutlet UILabel *PARTY_NAME;

// 库存月份
@property (weak, nonatomic) IBOutlet UILabel *STOCK_DATE;

// 填表日期
@property (weak, nonatomic) IBOutlet UILabel *SUBMIT_DATE;

// 库存状态
@property (weak, nonatomic) IBOutlet UIImageView *STOCK_STATE_imageView;

@end

@implementation GetStockListTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setStockM:(StockModel *)stockM {
    
    _stockM = stockM;
    
    _PARTY_CODE.text = _stockM.pARTYCODE;
    _PARTY_NAME.text = _stockM.pARTYNAME;
    _STOCK_DATE.text = _stockM.sTOCKDATE;
    _SUBMIT_DATE.text = [Tools getDate_yyyy_mm_dd_hh_mm_ss:_stockM.sUBMITDATE];
    if([_stockM.sTOCKSTATE isEqualToString:@"CANCEL"]) {
        
        _STOCK_STATE_imageView.image = [UIImage imageNamed:@"STOCK_STATE_CANCEL"];
    } else {
        
        _STOCK_STATE_imageView.image = nil;
    }
}

@end
