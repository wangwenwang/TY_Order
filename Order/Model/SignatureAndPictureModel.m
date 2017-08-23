//
//  SignatureAndPictureModel.m
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "SignatureAndPictureModel.h"

@implementation SignatureAndPictureModel

- (instancetype)init {
    if(self = [super init]) {
        _AUTOGRAPH = @"Autograph";
        _PICTURE = @"pricture";
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        
        _AUTOGRAPH = dict[@"AUTOGRAPH"] ? dict[@"AUTOGRAPH"] : _AUTOGRAPH;
        _PICTURE = dict[@"PICTURE"] ? dict[@"PICTURE"] : _PICTURE;
        _IDX = dict[@"IDX"] ? dict[@"IDX"] : _IDX;
        _PRODUCT_IDX = dict[@"PRODUCT_IDX"] ? dict[@"PRODUCT_IDX"] : _PRODUCT_IDX;
        _PRODUCT_URL = dict[@"PRODUCT_URL"] ? dict[@"PRODUCT_URL"] : _PRODUCT_URL;
        _REMARK = dict[@"REMARK"] ? dict[@"REMARK"] : _REMARK;
        
    } @catch (NSException *exception) {
        
    }
}

@end
