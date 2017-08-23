//
//  ProductPolicyModel.m
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "ProductPolicyModel.h"

@implementation ProductPolicyModel

- (instancetype)init {
    if(self = [super init]) {
        
        _POLICY_NAME = @"";
        _POLICY_TYPE = @"";
        _AMOUNT_START = @"";
        _AMOUNT_END = @"";
        _REQUEST_BATCH = @"";
        _SALE_PRICE = @"";
        _PolicyItems = nil;
        
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _POLICY_NAME = dict[@"POLICY_NAME"] ? dict[@"POLICY_NAME"] : _POLICY_NAME;
        _POLICY_TYPE = dict[@"POLICY_TYPE"] ? dict[@"POLICY_TYPE"] : _POLICY_TYPE;
        _AMOUNT_START = dict[@"AMOUNT_START"] ? dict[@"AMOUNT_START"] : _AMOUNT_START;
        _AMOUNT_END = dict[@"AMOUNT_END"] ? dict[@"AMOUNT_END"] : _AMOUNT_END;
        _REQUEST_BATCH = dict[@"REQUEST_BATCH"] ? dict[@"REQUEST_BATCH"] : _REQUEST_BATCH;
        _SALE_PRICE = dict[@"SALE_PRICE"] ? dict[@"SALE_PRICE"] : _SALE_PRICE;
        
        _PolicyItems = dict[@"PolicyItems"];
        
        if(_PolicyItems) {
            NSLog(@"PolicyItems   Y");
        }else {
            NSLog(@"PolicyItems   N");
        }
        
    } @catch (NSException *exception) {
        
    }
}

@end
