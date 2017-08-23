//
//  ProductChartModel.m
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ProductChartModel.h"

@implementation ProductChartModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _PRODUCT_NAME = @"";
        _PRODUCT_TYPE = @"";
        _ACT_PRICE = @"";
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    
    @try {
        _PRODUCT_NAME = dict[@"PRODUCT_NAME"] ? dict[@"PRODUCT_NAME"] : _PRODUCT_NAME;
        _PRODUCT_TYPE = dict[@"PRODUCT_TYPE"] ? dict[@"PRODUCT_TYPE"] : _PRODUCT_TYPE;
        _ACT_PRICE = dict[@"ACT_PRICE"] ? dict[@"ACT_PRICE"] : _ACT_PRICE;
    } @catch (NSException *exception) {
        
    }
}

@end
