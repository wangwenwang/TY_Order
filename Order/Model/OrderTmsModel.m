//
//  OrderTmsModel.m
//  Order
//
//  Created by 凯东源 on 16/10/10.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderTmsModel.h"
#import "OrderModel.h"

@implementation OrderTmsModel

- (instancetype)init {
    if(self = [super init]) {
        _IDX = @"";
        _ORD_TO_NAME = @"";
        _ORD_TO_ADDRESS = @"";
        _ORD_QTY = 0;
        _ORD_WEIGHT = @"";
        
        _ORD_VOLUME = @"";
        _TMS_QTY = 0;
        _TMS_WEIGHT = @"";
        _TMS_VOLUME = @"";
        _TmsList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    @try {
        _IDX = dict[@"IDX"] ? dict[@"IDX"] : @"";
        _ORD_TO_NAME = dict[@"ORD_TO_NAME"] ? dict[@"ORD_TO_NAME"] : @"";
        _ORD_TO_ADDRESS = dict[@"ORD_TO_ADDRESS"] ? dict[@"ORD_TO_ADDRESS"] : @"";
        _ORD_QTY = dict[@"ORD_QTY"] ? [dict[@"ORD_QTY"] doubleValue] : 0;
        _ORD_WEIGHT = dict[@"ORD_WEIGHT"] ? dict[@"ORD_WEIGHT"] : @"";
        _ORD_VOLUME = dict[@"ORD_VOLUME"] ? dict[@"ORD_VOLUME"] : @"";
        _TMS_QTY = dict[@"TMS_QTY"] ? [dict[@"TMS_QTY"] doubleValue] : 0;
        _TMS_WEIGHT = dict[@"TMS_WEIGHT"] ? dict[@"TMS_WEIGHT"] : @"";
        _TMS_VOLUME = dict[@"TMS_VOLUME"] ? dict[@"TMS_VOLUME"] : @"";
        
        //将tmsList转成模型
        [_TmsList removeAllObjects];
        NSArray *tmsLists = dict[@"TmsList"];
        for(int i = 0; i < tmsLists.count; i++) {
            OrderModel *m = [[OrderModel alloc] init];
            [m setDict:tmsLists[i]];
            [_TmsList addObject:m];
        }
    } @catch (NSException *exception) {
    }
}
@end
