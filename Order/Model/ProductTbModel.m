//
//  ProductTbModel.m
//  Order
//
//  Created by 凯东源 on 16/10/15.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ProductTbModel.h"

@implementation ProductTbModel

- (instancetype)init {
    if(self = [super init]) {
        _IDX = 0;
        _PRODUCT_TYPE = @"";
        _PRODUCT_CLASS = @"";
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _IDX = dict[@"IDX"] ? [dict[@"IDX"] longLongValue] : _IDX;
        _PRODUCT_TYPE = dict[@"PRODUCT_TYPE"] ? dict[@"PRODUCT_TYPE"] : _PRODUCT_TYPE;
        _PRODUCT_CLASS = dict[@"PRODUCT_CLASS"] ? dict[@"PRODUCT_CLASS"] : _PRODUCT_CLASS;
        
    } @catch (NSException *exception) {
        
    }
}

@end
