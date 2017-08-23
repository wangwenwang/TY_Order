//
//  ConfirmAddStockTableViewCell.m
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import "ConfirmAddStockTableViewCell.h"

@interface ConfirmAddStockTableViewCell ()

// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

// 产品规格
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME2;

// 产品原价
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_PRICE;

// 库存数量
@property (weak, nonatomic) IBOutlet UILabel *STOCK_QTY;

// 生产日期
@property (weak, nonatomic) IBOutlet UILabel *PRODUCTION_DATE;

@end

@implementation ConfirmAddStockTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setProductM:(ProductModel *)productM {
    
    _productM = productM;
    
    if(_productM) {
        
        // 产品名称
        _PRODUCT_NAME.text = [self getProductName:_productM.PRODUCT_NAME];
        
        // 产品规格
        _PRODUCT_NAME2.text = [self getProductFormat:_productM.PRODUCT_NAME];
        
        // 产品原价
        _PRODUCT_PRICE.text = [NSString stringWithFormat:@"￥%.1f", _productM.PRODUCT_PRICE];
        
        // 数量
        _STOCK_QTY.text = [NSString stringWithFormat:@"%lld", _productM.STOCK_QTY];
        
        // 生产日期
        _PRODUCTION_DATE.text = productM.PRODUCTION_DATE;
    }
}


#pragma mark - 功能函数

// 获取产品名称，传入参数：ProductModel模型，PRODUCT_NAME变量
- (NSString *)getProductName:(NSString *)str {
    NSArray *array = [str componentsSeparatedByString:@","];
    
    if(array.count > 0) {
        return array[0];
    } else {
        return @"";
    }
}


// 获取产品规格，传入参数：ProductModel模型，PRODUCT_NAME变量
- (NSString *)getProductFormat:(NSString *)str {
    NSArray *array = [str componentsSeparatedByString:@","];
    
    if(array.count > 1) {
        return array[1];
    } else {
        return @"";
    }
}

@end
