//
//  OrderGiftModel.m
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderGiftModel.h"

@implementation OrderGiftModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _TYPE_NAME = @"";
        _QTY = 0;
        _PRICE = 0;
        _choiceCount = 0;
        _isChecked = NO;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    OrderGiftModel *instance = [[OrderGiftModel alloc] init];
    if (instance) {
        instance.TYPE_NAME = self.TYPE_NAME;
        instance.QTY = self.QTY;
        instance.PRICE = self.PRICE;
        instance.choiceCount = self.choiceCount;
        instance.isChecked = self.isChecked;
    }
    return instance;
}

- (void)setDict:(NSDictionary *)dict {
    
    @try {
        
        _TYPE_NAME = dict[@"TYPE_NAME"] ? dict[@"TYPE_NAME"] : _TYPE_NAME;
        _QTY = dict[@"QTY"] ? [dict[@"QTY"] doubleValue] : _QTY;
        _PRICE = dict[@"PRICE"] ? [dict[@"PRICE"] doubleValue] : _PRICE;
        _choiceCount = dict[@"choiceCount"] ? [dict[@"choiceCount"] doubleValue] : _choiceCount;
        _isChecked = dict[@"isChecked"] ? [dict[@"isChecked"] boolValue] : _isChecked;
    } @catch (NSException *exception) {
        
    }
}

@end
