//
//  PolicyItemModel.m
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "PolicyItemModel.h"

@implementation PolicyItemModel

- (instancetype)init {
    if(self = [super init]) {
        
        _Condition = nil;
        _Discount = nil;
        
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _Condition = nil;
        _Discount = nil;
        
    } @catch (NSException *exception) {
        
    }
}

@end
