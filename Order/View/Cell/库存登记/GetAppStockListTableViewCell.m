//
//  GetAppStockListTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "GetAppStockListTableViewCell.h"
#import "Tools.h"

@interface GetAppStockListTableViewCell ()

// 产品代码
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NO;

// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

// 生产日期
@property (weak, nonatomic) IBOutlet UILabel *PRODUCTION_DATE;

// 数量
@property (weak, nonatomic) IBOutlet UILabel *STOCK_QTY;

// 保质期
@property (weak, nonatomic) IBOutlet UILabel *EXPIRATION_DAY;

// 产品货龄
@property (weak, nonatomic) IBOutlet UILabel *HUO_LING;

// 货龄状态
@property (weak, nonatomic) IBOutlet UILabel *A_ZHUO_LING;

// 填表时货龄
@property (weak, nonatomic) IBOutlet UILabel *THUO_LING;

// 填表货龄状态
@property (weak, nonatomic) IBOutlet UILabel *A_ZTHUO_LING;

// 产品名称换行 默认8
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PRODUCT_NAME_bottom;

// 产品到期日期
@property (weak, nonatomic) IBOutlet UILabel *DAOQI;

@end

@implementation GetAppStockListTableViewCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setAppStockM:(AppStockModel *)appStockM {
    
    _appStockM = appStockM;
    _PRODUCT_NO.text = _appStockM.pRODUCTNO;
    _PRODUCT_NAME.text = _appStockM.pRODUCTNAME;
    _PRODUCTION_DATE.text = [Tools getDate_yyyy_mm_dd_hh_mm_ss:_appStockM.pRODUCTIONDATE];
    _DAOQI.text = [Tools getDate_yyyy_mm_dd_hh_mm_ss:_appStockM.dAOQI];
    _STOCK_QTY.text = _appStockM.sTOCKQTY;
    _EXPIRATION_DAY.text = [NSString stringWithFormat:@"%@个月", _appStockM.eXPIRATIONDAY];
    _HUO_LING.text = _appStockM.hUOLING;
    _A_ZHUO_LING.text = _appStockM.aZHUOLING;
    _THUO_LING.text = _appStockM.tHUOLING;
    _A_ZTHUO_LING.text = _appStockM.aZTHUOLING;
    
    NSDateFormatter *_formatter_dd = [[NSDateFormatter alloc] init];
    [_formatter_dd setDateFormat:@"yyyy-MM-dd"];
    
    // 产品名称换行
    
    // 单行高度
    CGFloat oneLine = [Tools getHeightOfString:@"fds" fontSize:_PRODUCT_NAME.font.pointSize andWidth:(ScreenWidth - 8 - 69.5 - 8)];
    
    CGFloat PRODUCT_NAME_height = [Tools getHeightOfString:_PRODUCT_NAME.text fontSize:_PRODUCT_NAME.font.pointSize andWidth:(ScreenWidth - 8 - 69.5 - 8)];
    
    if(PRODUCT_NAME_height > oneLine) {
        
        _PRODUCT_NAME_bottom.constant = _PRODUCT_NAME_bottom.constant + PRODUCT_NAME_height - oneLine;
    }
}

@end
