//
//  ProductModel.m
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ProductModel.h"
#import "ProductPolicyModel.h"

@implementation ProductModel

- (instancetype)init {
    if(self = [super init]) {
        _IDX = 0;
        _BUSINESS_IDX = @"";
        _PRODUCT_NO = @"";
        _PRODUCT_NAME = @"";
        _PRODUCT_DESC = @"";
        _PRODUCT_BARCODE = @"";
        _PRODUCT_TYPE = @"";
        _PRODUCT_CLASS = @"";
        _PRODUCT_PRICE = 0;
        _PRODUCT_URL = @"";
        _PRODUCT_VOLUME = 0;
        _PRODUCT_WEIGHT = 0;
        _PRODUCT_POLICY = [[NSMutableArray alloc] init];
        _ISINVENTORY = @"N";     
        _PRODUCT_INVENTORY = 0;
        _PRODUCT_CURRENT_PRICE = 0;
        _CHOICED_SIZE = 0;
        
        _isClickCell = NO;
//        _selectedProductCount = 0;
        _PRODUCTION_DATE = @"";
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _IDX = dict[@"IDX"] ? [dict[@"IDX"] longLongValue] : _IDX;
        _BUSINESS_IDX = dict[@"BUSINESS_IDX"] ? dict[@"BUSINESS_IDX"] : _BUSINESS_IDX;
        _PRODUCT_NO = dict[@"PRODUCT_NO"] ? dict[@"PRODUCT_NO"] : _PRODUCT_NO;
        _PRODUCT_NAME = dict[@"PRODUCT_NAME"] ? dict[@"PRODUCT_NAME"] : _PRODUCT_NAME;
        _PRODUCT_DESC = dict[@"PRODUCT_DESC"] ? dict[@"PRODUCT_DESC"] : _PRODUCT_DESC;
        _PRODUCT_BARCODE = dict[@"PRODUCT_BARCODE"] ? dict[@"PRODUCT_BARCODE"] : _PRODUCT_BARCODE;
        _PRODUCT_TYPE = dict[@"PRODUCT_TYPE"] ? dict[@"PRODUCT_TYPE"] : _PRODUCT_TYPE;
        _PRODUCT_CLASS = dict[@"PRODUCT_CLASS"] ? dict[@"PRODUCT_CLASS"] : _PRODUCT_CLASS;
        _PRODUCT_PRICE = dict[@"PRODUCT_PRICE"] ? [dict[@"PRODUCT_PRICE"] doubleValue]: _PRODUCT_PRICE;
        _PRODUCT_URL = dict[@"PRODUCT_URL"] ? dict[@"PRODUCT_URL"] : _PRODUCT_URL;
        _PRODUCT_VOLUME = dict[@"PRODUCT_VOLUME"] ? [dict[@"PRODUCT_VOLUME"] doubleValue] : _PRODUCT_VOLUME;
        _PRODUCT_WEIGHT = dict[@"PRODUCT_WEIGHT"] ? [dict[@"PRODUCT_WEIGHT"] doubleValue] : _PRODUCT_WEIGHT;
        
        
        
        NSArray *PRODUCT_POLICYs = dict[@"PRODUCT_POLICY"] ? dict[@"PRODUCT_POLICY"] : [[NSArray alloc] init];
        for(int i = 0; i < PRODUCT_POLICYs.count; i++) {
            NSDictionary *dict = PRODUCT_POLICYs[i];
            ProductPolicyModel *m = [[ProductPolicyModel alloc] init];
            [m setDict:dict];
            [_PRODUCT_POLICY addObject:m];
        }
        
        
        
        _ISINVENTORY = dict[@"ISINVENTORY"] ? dict[@"ISINVENTORY"] : _ISINVENTORY;
        _PRODUCT_INVENTORY = dict[@"PRODUCT_INVENTORY"] ? [dict[@"PRODUCT_INVENTORY"] longLongValue] : _PRODUCT_INVENTORY;
        _PRODUCT_CURRENT_PRICE = dict[@"PRODUCT_CURRENT_PRICE"] ? [dict[@"PRODUCT_CURRENT_PRICE"] doubleValue] : _PRODUCT_CURRENT_PRICE;
        _CHOICED_SIZE = dict[@"CHOICED_SIZE"] ? [dict[@"CHOICED_SIZE"] longLongValue] : _CHOICED_SIZE;
        
    } @catch (NSException *exception) {
        
    }
}

@end
