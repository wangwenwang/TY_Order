//
//  AddressModel.m
//  Order
//
//  Created by 凯东源 on 16/10/13.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

- (instancetype)init {
    if(self = [super init]) {
        _IDX = @"";
        _ADDRESS_CODE = @"";
        _ADDRESS_ALIAS = @"";
        _ADDRESS_REGION = @"";
        _ADDRESS_ZIP = @"";
        
        _ADDRESS_INFO = @"";
        _CONTACT_PERSON = @"";
        _CONTACT_TEL = @"";
        _CONTACT_FAX = @"";
        _CONTACT_SMS = @"";
        
        _ADDRESS_REMARK = @"";
        _COORDINATE = @"";
        
        _defaultAddress = NO;
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _IDX = dict[@"IDX"] ? dict[@"IDX"] : @"";
        _ADDRESS_CODE = dict[@"ADDRESS_CODE"] ? dict[@"ADDRESS_CODE"] : @"";
        _ADDRESS_ALIAS = dict[@"ADDRESS_ALIAS"] ? dict[@"ADDRESS_ALIAS"] : @"";
        _ADDRESS_REGION = dict[@"ADDRESS_REGION"] ? dict[@"ADDRESS_REGION"] : @"";
        _ADDRESS_ZIP = dict[@"ADDRESS_ZIP"] ? dict[@"ADDRESS_ZIP"] : @"";
        _ADDRESS_INFO = dict[@"ADDRESS_INFO"] ? dict[@"ADDRESS_INFO"] : @"";
        _CONTACT_PERSON = dict[@"CONTACT_PERSON"] ? dict[@"CONTACT_PERSON"] : @"";
        _CONTACT_TEL = dict[@"CONTACT_TEL"] ? dict[@"CONTACT_TEL"] : @"";
        _CONTACT_FAX = dict[@"CONTACT_FAX"] ? dict[@"CONTACT_FAX"] : @"";
        _CONTACT_SMS = dict[@"CONTACT_SMS"] ? dict[@"CONTACT_SMS"] : @"";
        _ADDRESS_REMARK = dict[@"ADDRESS_REMARK"] ? dict[@"ADDRESS_REMARK"] : @"";
        _COORDINATE = dict[@"COORDINATE"] ? dict[@"COORDINATE"] : @"";
        
    } @catch (NSException *exception) {
        
    }
}

@end
