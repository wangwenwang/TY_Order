//
//  CustomerChartModel.m
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "CustomerChartModel.h"

@implementation CustomerChartModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _TO_CITY = @"";
        _ORD_QTY = 0.0;
        _ORG_PRICE = 0.0;
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    
    @try {
        _TO_CITY = dict[@"TO_CITY"] ? dict[@"TO_CITY"] : _TO_CITY;
        _ORD_QTY = dict[@"ORD_QTY"] ? [dict[@"ORD_QTY"] doubleValue] : _ORD_QTY;
        _ORG_PRICE = dict[@"ORG_PRICE"] ? [dict[@"ORG_PRICE"] doubleValue] : _ORG_PRICE;
    } @catch (NSException *exception) {
        
    }
}

@end
