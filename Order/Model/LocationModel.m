//
//  LocationModel.m
//  YBDriver
//
//  Created by 凯东源 on 16/9/7.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _ID = @"";
        _userIdx = @"";
        _CORDINATEX = 0.0;
        _CORDINATEY = 0.0;
        _ADDRESS = @"";
        _CREATETIME = [NSDate date];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    
    @try {
        _ID = dict[@"IDX"] ? dict[@"IDX"] : _ID;
        _userIdx = dict[@"userIdx"] ? dict[@"userIdx"] : _userIdx;
        _CORDINATEX = dict[@"CORDINATEX"] ? [dict[@"CORDINATEX"] doubleValue] : _CORDINATEX;
        _CORDINATEY = dict[@"CORDINATEY"] ? [dict[@"CORDINATEY"] doubleValue] : _CORDINATEY;
        _ADDRESS = dict[@"ADDRESS"] ? dict[@"ADDRESS"] : _ADDRESS;
        _CREATETIME = dict[@"CREATETIME"] ? dict[@"CREATETIME"] : _CREATETIME;
    } @catch (NSException *exception) {
        
    }
}

@end
