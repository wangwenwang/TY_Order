//
//  PartyModel.m
//  Order
//
//  Created by 凯东源 on 16/10/12.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "PartyModel.h"

@implementation PartyModel
- (instancetype)init {
    if(self = [super init]) {
        _IDX = @"";
        _PARTY_CODE = @"";
        _PARTY_NAME = @"";
        _PARTY_PROPERTY = 0;
        _PARTY_CLASS = @"";
        
        _PARTY_TYPE = @"";
        _PARTY_COUNTRY = 0;
        _PARTY_PROVINCE = @"";
        _PARTY_CITY = @"";
        _PARTY_REMARK = @"";
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _IDX = dict[@"IDX"] ? dict[@"IDX"] : @"";
        _PARTY_CODE = dict[@"PARTY_CODE"] ? dict[@"PARTY_CODE"] : @"";
        _PARTY_NAME = dict[@"PARTY_NAME"] ? dict[@"PARTY_NAME"] : @"";
        _PARTY_PROPERTY = dict[@"PARTY_PROPERTY"] ? dict[@"PARTY_PROPERTY"] : @"";
        _PARTY_CLASS = dict[@"PARTY_CLASS"] ? dict[@"PARTY_CLASS"] : @"";
        _PARTY_TYPE = dict[@"PARTY_TYPE"] ? dict[@"PARTY_TYPE"] : @"";
        _PARTY_COUNTRY = dict[@"PARTY_COUNTRY"] ? dict[@"PARTY_COUNTRY"] : @"";
        _PARTY_PROVINCE = dict[@"PARTY_PROVINCE"] ? dict[@"PARTY_PROVINCE"] : @"";
        _PARTY_CITY = dict[@"PARTY_CITY"] ? dict[@"PARTY_CITY"] : @"";
        _PARTY_REMARK = dict[@"PARTY_REMARK"] ? dict[@"PARTY_REMARK"] : @"";
        
    } @catch (NSException *exception) {
        
    }
}
@end
