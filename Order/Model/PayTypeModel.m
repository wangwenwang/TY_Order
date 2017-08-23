//
//  PayTypeModel.m
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "PayTypeModel.h"

@implementation PayTypeModel
- (instancetype)init {
    if(self = [super init]) {
        _Key = @"";
        _Text = @"";
        _SALE_PRICE = 0;
        _selected = NO;
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _Key = dict[@"Key"] ? dict[@"Key"] : @"";
        _Text = dict[@"Text"] ? dict[@"Text"] : @"";
        _SALE_PRICE = dict[@"SALE_PRICE"] ? [dict[@"SALE_PRICE"] doubleValue] : 0;
        
    } @catch (NSException *exception) {
        
    }
}

@end
