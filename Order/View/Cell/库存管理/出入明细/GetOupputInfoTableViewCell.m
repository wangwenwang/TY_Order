//
//  GetOupputInfoTableViewCell.m
//  Order
//
//  Created by 凯东源 on 2017/8/22.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetOupputInfoTableViewCell.h"
#import "Tools.h"

@interface GetOupputInfoTableViewCell ()

// 产品代码
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NO;

// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

// 出库数量
@property (weak, nonatomic) IBOutlet UILabel *OUTPUT_QTY;

// 出库重量
@property (weak, nonatomic) IBOutlet UILabel *OUTPUT_WEIGHT;

// 出库体积
@property (weak, nonatomic) IBOutlet UILabel *OUTPUT_VOLUME;

// 产品原价
@property (weak, nonatomic) IBOutlet UILabel *ORG_PRICE;

// 付款价
@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;

// 总价
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end

@implementation GetOupputInfoTableViewCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setGetOupputItemM:(GetOupputItemModel *)getOupputItemM {
    
    _PRODUCT_NO.text = getOupputItemM.pRODUCTNO;
    _PRODUCT_NAME.text = getOupputItemM.pRODUCTNAME;
    _OUTPUT_QTY.text = [Tools OneDecimal:getOupputItemM.oUTPUTQTY];
    _OUTPUT_WEIGHT.text = [Tools TwoDecimal:getOupputItemM.oUTPUTWEIGHT];
    _OUTPUT_VOLUME.text = [Tools TwoDecimal:getOupputItemM.oUTPUTVOLUME];
    _ORG_PRICE.text = [Tools TwoDecimal:getOupputItemM.oRGPRICE];
    
    // 付款价
    CGFloat payPriceFlo = [getOupputItemM.oRGPRICE floatValue] - [getOupputItemM.mJPRICE floatValue] - [getOupputItemM.aCTPRICE floatValue];
    NSString *payStr = [NSString stringWithFormat:@"%.2f", payPriceFlo];
    
    // 总价
    CGFloat floAll = payPriceFlo * [getOupputItemM.oUTPUTQTY floatValue];
    NSString *floAllStr = [NSString stringWithFormat:@"%.2f", floAll];
    
    _payPriceLabel.text = payStr;
    _totalPriceLabel.text = floAllStr;
}

@end
