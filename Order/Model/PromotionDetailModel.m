//
//  PromotionDetailModel.m
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "PromotionDetailModel.h"

@implementation PromotionDetailModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _IDX = 0;
        _ENT_IDX = 0;
        _ORDER_IDX = 0;
        _PRODUCT_TYPE = @"";
        _PRODUCT_IDX = 0;
        _PRODUCT_NO = @"";
        _PRODUCT_NAME = @"";
        _LINE_NO = 0;
        _PO_QTY = 0;
        _PO_UOM = @"";
        _PO_WEIGHT = 0.0;
        _PO_VOLUME = 0.0;
        _ORG_PRICE = 0.0;
        _ACT_PRICE = 0.0;
        _SALE_REMARK = @"";
        _MJ_REMARK = @"";
        _MJ_PRICE = 0.0;
        _LOTTABLE01 = @"";
        _LOTTABLE02 = @"";
        _LOTTABLE03 = @"";
        _LOTTABLE04 = @"";
        _LOTTABLE05 = @"";
        _LOTTABLE06 = @"N";
        _LOTTABLE07 = @"";
        _LOTTABLE08 = @"";
        _LOTTABLE09 = @"";
        _LOTTABLE10 = @"";
        _LOTTABLE11 = 0;
        _LOTTABLE12 = 0.0;
        _LOTTABLE13 = 0.0;
        _OPERATOR_IDX = 0;
        _ADD_DATE = @"";
        _EDIT_DATE = @"";
        _PRODUCT_URL = @"";
    }
    return self;
}


- (void)setDict:(NSDictionary *)dict {
    
    @try {
        
        _IDX = dict[@"IDX"] ? [dict[@"IDX"] longLongValue] : _IDX;
        _ENT_IDX = dict[@"ENT_IDX"] ? [dict[@"ENT_IDX"] longLongValue] : _ENT_IDX;
        _ORDER_IDX = dict[@"ORDER_IDX"] ? [dict[@"ORDER_IDX"] longLongValue] : _ORDER_IDX;
        _PRODUCT_TYPE = dict[@"PRODUCT_TYPE"] ? dict[@"PRODUCT_TYPE"] : _PRODUCT_TYPE;
        _PRODUCT_IDX = dict[@"PRODUCT_IDX"] ? [dict[@"PRODUCT_IDX"] longLongValue] : _PRODUCT_IDX;
        _PRODUCT_NO = dict[@"PRODUCT_NO"] ? dict[@"PRODUCT_NO"] : _PRODUCT_NO;
        _PRODUCT_NAME = dict[@"PRODUCT_NAME"] ? dict[@"PRODUCT_NAME"] : _PRODUCT_NAME;
        _LINE_NO = dict[@"LINE_NO"] ? [dict[@"LINE_NO"] longLongValue] : _LINE_NO;
        _PO_QTY = dict[@"PO_QTY"] ? [dict[@"PO_QTY"] longLongValue] : _PO_QTY;
        _PO_UOM = dict[@"PO_UOM"] ? dict[@"PO_UOM"] : _PO_UOM;
        _PO_WEIGHT = dict[@"PO_WEIGHT"] ? [dict[@"PO_WEIGHT"] doubleValue] : _PO_WEIGHT;
        _PO_VOLUME = dict[@"PO_VOLUME"] ? [dict[@"PO_VOLUME"] doubleValue] : _PO_VOLUME;
        _ORG_PRICE = dict[@"ORG_PRICE"] ? [dict[@"ORG_PRICE"] doubleValue] : _ORG_PRICE;
        _ACT_PRICE = dict[@"ACT_PRICE"] ? [dict[@"ACT_PRICE"] doubleValue] : _ACT_PRICE;
        _SALE_REMARK = dict[@"SALE_REMARK"] ? dict[@"SALE_REMARK"] : _SALE_REMARK;
        _MJ_REMARK = dict[@"MJ_REMARK"] ? dict[@"MJ_REMARK"] : _MJ_REMARK;
        _MJ_PRICE = dict[@"MJ_PRICE"] ? [dict[@"MJ_PRICE"] doubleValue] : _MJ_PRICE;
        _LOTTABLE01 = dict[@"LOTTABLE01"] ? dict[@"LOTTABLE01"] : _LOTTABLE01;
        _LOTTABLE02 = dict[@"LOTTABLE02"] ? dict[@"LOTTABLE02"] : _LOTTABLE02;
        _LOTTABLE03 = dict[@"LOTTABLE03"] ? dict[@"LOTTABLE03"] : _LOTTABLE03;
        _LOTTABLE04 = dict[@"LOTTABLE04"] ? dict[@"LOTTABLE04"] : _LOTTABLE04;
        _LOTTABLE05 = dict[@"LOTTABLE05"] ? dict[@"LOTTABLE05"] : _LOTTABLE05;
        _LOTTABLE06 = dict[@"LOTTABLE06"] ? dict[@"LOTTABLE06"] : _LOTTABLE06;
        _LOTTABLE07 = dict[@"LOTTABLE07"] ? dict[@"LOTTABLE07"] : _LOTTABLE07;
        _LOTTABLE07 = dict[@"LOTTABLE07"] ? dict[@"LOTTABLE07"] : _LOTTABLE07;
        _LOTTABLE08 = dict[@"LOTTABLE08"] ? dict[@"LOTTABLE08"] : _LOTTABLE08;
        _LOTTABLE09 = dict[@"LOTTABLE09"] ? dict[@"LOTTABLE09"] : _LOTTABLE09;
        _LOTTABLE10 = dict[@"LOTTABLE10"] ? dict[@"LOTTABLE10"] : _LOTTABLE10;
        _LOTTABLE11 = dict[@"LOTTABLE11"] ? [dict[@"LOTTABLE11"] longLongValue] : _LOTTABLE11;
        _LOTTABLE12 = dict[@"LOTTABLE12"] ? [dict[@"LOTTABLE12"] doubleValue ] : _LOTTABLE12;
        _LOTTABLE13 = dict[@"LOTTABLE13"] ? [dict[@"LOTTABLE13"] doubleValue ] : _LOTTABLE13;
        _OPERATOR_IDX = dict[@"OPERATOR_IDX"] ? [dict[@"OPERATOR_IDX"] longLongValue] : _OPERATOR_IDX;
        _ADD_DATE = dict[@"ADD_DATE"] ? dict[@"ADD_DATE"] : _ADD_DATE;
        _EDIT_DATE = dict[@"EDIT_DATE"] ? dict[@"EDIT_DATE"] : _EDIT_DATE;
        _PRODUCT_URL = dict[@"PRODUCT_URL"] ? dict[@"PRODUCT_URL"] : _PRODUCT_URL;
    } @catch (NSException *exception) {
        
    }
    
}

@end
