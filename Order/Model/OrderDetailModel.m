//
//  OrderDetailModel.m
//  YBDriver
//
//  Created by 凯东源 on 16/9/3.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

- (instancetype)init {
    if(self = [super init]) {
        _PRODUCT_NO = @"";
        _PRODUCT_NAME = @"";
        _ORDER_QTY = 0;
        _ORDER_UOM = 0;
        _ORDER_WEIGHT = @"";
        
        _ORDER_VOLUME = @"";
        _ISSUE_QTY = 0;
        _ISSUE_WEIGHT = @"";
        _ISSUE_VOLUME = @"";
        _PRODUCT_PRICE = 0;
        
        _ACT_PRICE = 0;
        _MJ_PRICE = @"";
        _MJ_REMARK = @"";
        _ORG_PRICE = 0;
        _PRODUCT_URL = @"";
        
        _PRODUCT_TYPE = @"";
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _PRODUCT_NO = dict[@"PRODUCT_NO"] ? dict[@"PRODUCT_NO"] : @"";
        _PRODUCT_NAME = dict[@"PRODUCT_NAME"] ? dict[@"PRODUCT_NAME"] : @"";
        _ORDER_QTY = dict[@"ORDER_QTY"] ? [dict[@"ORDER_QTY"] doubleValue] : 0;
        _ORDER_UOM = dict[@"ORDER_UOM"] ? [dict[@"ORDER_UOM"] doubleValue] : 0;
        _ORDER_WEIGHT = dict[@"ORDER_WEIGHT"] ? dict[@"ORDER_WEIGHT"] : @"";
        
        _ORDER_VOLUME = dict[@"ORDER_VOLUME"] ? dict[@"ORDER_VOLUME"] : @"";
        _ISSUE_QTY = dict[@"ISSUE_QTY"] ? [dict[@"ISSUE_QTY"] doubleValue] : 0;
        _ISSUE_WEIGHT = dict[@"ISSUE_WEIGHT"] ? dict[@"ISSUE_WEIGHT"] : @"";
        _ISSUE_VOLUME = dict[@"ISSUE_VOLUME"] ? dict[@"ISSUE_VOLUME"] : @"";
        _PRODUCT_PRICE = dict[@"PRODUCT_PRICE"] ? [dict[@"PRODUCT_PRICE"] doubleValue] : 0;
        
        _ACT_PRICE = dict[@"ACT_PRICE"] ? [dict[@"ACT_PRICE"] doubleValue] : 0;
        _MJ_PRICE = dict[@"MJ_PRICE"] ? dict[@"MJ_PRICE"] : @"";
        _MJ_REMARK = dict[@"MJ_REMARK"] ? dict[@"MJ_REMARK"] : @"";
        _ORG_PRICE = dict[@"ORG_PRICE"] ? [dict[@"ORG_PRICE"] doubleValue] : 0;
        _PRODUCT_URL = dict[@"PRODUCT_URL"] ? dict[@"PRODUCT_URL"] : @"";
        
        _PRODUCT_TYPE = dict[@"PRODUCT_TYPE"] ? dict[@"PRODUCT_TYPE"] : @"";
        
    } @catch (NSException *exception) {
        
    }
}

@end
