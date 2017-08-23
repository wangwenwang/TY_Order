//
//  StateTackModel.m
//  YBDriver
//
//  Created by 凯东源 on 16/9/3.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "StateTackModel.h"

@implementation StateTackModel

- (instancetype)init {
    if(self = [super init]) {
        _STATE_TIME = @"";
        _ORDER_STATE = @"";
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    _STATE_TIME = dict[@"STATE_TIME"] ? dict[@"STATE_TIME"] : @"";
    _ORDER_STATE = dict[@"ORDER_STATE"] ? dict[@"ORDER_STATE"] : @"";
}

@end
