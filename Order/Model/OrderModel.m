//
//  OrderModel.m
//  YBDriver
//
//  Created by 凯东源 on 16/9/3.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "OrderModel.h"
#import "StateTackModel.h"

@implementation OrderModel

- (instancetype)init {
    if(self = [super init]) {
        _TMS_DATE_LOAD = @"";
        _TMS_DATE_ISSUE = @"";
        _TMS_SHIPMENT_NO = @"";
        _TMS_FLEET_NAME = @"";
        _ORD_IDX = @"";
        
        _IDX = @"";
        _ORD_NO = @"";
        _ORD_TO_NAME = @"";
        _PARTY_TYPE = @"";
        _ORD_TO_CNAME = @"";
        _ORD_TO_ADDRESS = @"";
        
        _ORD_QTY = 0;
        _ORD_WEIGHT = @"";
        _ORD_VOLUME = @"";
        _ORD_ISSUE_QTY = 0;
        _ORD_ISSUE_WEIGHT = @"";
        _ORD_ISSUE_VOLUME = @"";
        
        _ORD_WORKFLOW = @"";
        _OMS_SPLIT_TYPE = @"";
        _OMS_PARENT_NO = @"";
        _ORD_STATE = @"";
        _ORD_DATE_ADD = @"";
        _ADD_CODE = @"";
        
        _ORD_REQUEST_ISSUE = @"";
        _ORD_FROM_NAME = @"";
        _FROM_COORDINATE = @"";
        _TO_COORDINATE = @"";
        _ORD_REMARK_CLIENT = @"";
        _TMS_DRIVER_NAME = @"";
        
        _TMS_PLATE_NUMBER = @"";
        _TMS_DRIVER_TEL = @"";
        _PAYMENT_TYPE = @"";
        _ORG_PRICE = 0;
        _ACT_PRICE = 0;
        _MJ_PRICE = 0;
        
        _ORD_REMARK_CONSIGNEE = @"";
        _MJ_REMARK = @"";
        _DRIVER_PAY = @"";
        
        _OrderDetails = [[NSMutableArray alloc] init];
        _StateTacks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    
    @try {
        _TMS_DATE_LOAD = dict[@"TMS_DATE_LOAD"] ? dict[@"TMS_DATE_LOAD"] : @"";
        _TMS_DATE_ISSUE = dict[@"TMS_DATE_ISSUE"] ? dict[@"TMS_DATE_ISSUE"] : @"";
        _TMS_SHIPMENT_NO = dict[@"TMS_SHIPMENT_NO"] ? dict[@"TMS_SHIPMENT_NO"] : @"";
        _TMS_FLEET_NAME = dict[@"TMS_FLEET_NAME"] ? dict[@"TMS_FLEET_NAME"] : @"";
        _ORD_IDX = dict[@"ORD_IDX"] ? dict[@"ORD_IDX"] : @"";
        
        _IDX = dict[@"IDX"] ? dict[@"IDX"] : @"";
        _ORD_NO = dict[@"ORD_NO"] ? dict[@"ORD_NO"] : @"";
        _ORD_TO_NAME = dict[@"ORD_TO_NAME"] ? dict[@"ORD_TO_NAME"] : @"";
        _PARTY_TYPE = dict[@"PARTY_TYPE"] ? dict[@"PARTY_TYPE"] : @"";
        _ORD_TO_CNAME = dict[@"ORD_TO_CNAME"] ? dict[@"ORD_TO_CNAME"] : @"";
        _ORD_TO_ADDRESS = dict[@"ORD_TO_ADDRESS"] ? dict[@"ORD_TO_ADDRESS"] : @"";
        
        _ORD_QTY = dict[@"ORD_QTY"] ? [dict[@"ORD_QTY"] floatValue] : 0;
        _ORD_WEIGHT = dict[@"ORD_WEIGHT"] ? dict[@"ORD_WEIGHT"] : @"";
        _ORD_VOLUME = dict[@"ORD_VOLUME"] ? dict[@"ORD_VOLUME"] : @"";
        _ORD_ISSUE_QTY = dict[@"ORD_ISSUE_QTY"] ? [dict[@"ORD_ISSUE_QTY"] doubleValue] : 0;
        _ORD_ISSUE_WEIGHT = dict[@"ORD_ISSUE_WEIGHT"] ? dict[@"ORD_ISSUE_WEIGHT"] : @"";
        _ORD_ISSUE_VOLUME = dict[@"ORD_ISSUE_VOLUME"] ? dict[@"ORD_ISSUE_VOLUME"] : @"";
        
        _ORD_WORKFLOW = dict[@"ORD_WORKFLOW"] ? dict[@"ORD_WORKFLOW"] : @"";
        _OMS_SPLIT_TYPE = dict[@"OMS_SPLIT_TYPE"] ? dict[@"OMS_SPLIT_TYPE"] : @"";
        _OMS_PARENT_NO = dict[@"OMS_PARENT_NO"] ? dict[@"OMS_PARENT_NO"] : @"";
        _ORD_STATE = dict[@"ORD_STATE"] ? dict[@"ORD_STATE"] : @"";
        _ORD_DATE_ADD = dict[@"ORD_DATE_ADD"] ? dict[@"ORD_DATE_ADD"] : @"";
        _ADD_CODE = dict[@"ADD_CODE"] ? dict[@"ADD_CODE"] : @"";
        
        _ORD_REQUEST_ISSUE = dict[@"ORD_REQUEST_ISSUE"] ? dict[@"ORD_REQUEST_ISSUE"] : @"";
        _ORD_FROM_NAME = dict[@"ORD_FROM_NAME"] ? dict[@"ORD_FROM_NAME"] : @"";
        _FROM_COORDINATE = dict[@"FROM_COORDINATE"] ? dict[@"FROM_COORDINATE"] : @"";
        _TO_COORDINATE = dict[@"TO_COORDINATE"] ? dict[@"TO_COORDINATE"] : @"";
        _ORD_REMARK_CLIENT = dict[@"ORD_REMARK_CLIENT"] ? dict[@"ORD_REMARK_CLIENT"] : @"";
        _TMS_DRIVER_NAME = dict[@"TMS_DRIVER_NAME"] ? dict[@"TMS_DRIVER_NAME"] : @"";
        
        _TMS_PLATE_NUMBER = dict[@"TMS_PLATE_NUMBER"] ? dict[@"TMS_PLATE_NUMBER"] : @"";
        _TMS_DRIVER_TEL = dict[@"TMS_DRIVER_TEL"] ? dict[@"TMS_DRIVER_TEL"] : @"";
        _PAYMENT_TYPE = dict[@"PAYMENT_TYPE"] ? dict[@"PAYMENT_TYPE"] : @"";
        _ORG_PRICE = dict[@"ORG_PRICE"] ? [dict[@"ORG_PRICE"] doubleValue] : 0;
        _ACT_PRICE = dict[@"ACT_PRICE"] ? [dict[@"ACT_PRICE"] doubleValue] : 0;
        _MJ_PRICE = dict[@"MJ_PRICE"] ? [dict[@"MJ_PRICE"] doubleValue] : 0;
        
        _ORD_REMARK_CONSIGNEE = dict[@"ORD_REMARK_CONSIGNEE"] ? dict[@"ORD_REMARK_CONSIGNEE"] : @"";
        _MJ_REMARK = dict[@"MJ_REMARK"] ? dict[@"MJ_REMARK"] : @"";
        _DRIVER_PAY = dict[@"DRIVER_PAY"] ? dict[@"DRIVER_PAY"] : @"";
        
        NSArray *orderDetails = dict[@"OrderDetails"] ? dict[@"OrderDetails"] : [[NSArray alloc] init];
        [_OrderDetails removeAllObjects];
        for(int i = 0; i < orderDetails.count; i++) {
            OrderDetailModel *m = [[OrderDetailModel alloc] init];
            [m setDict:orderDetails[i]];
            [_OrderDetails addObject:m];
        }
            
        NSArray *stateTacks = dict[@"StateTack"] ? dict[@"StateTack"] : [[NSArray alloc] init];
        [_StateTacks removeAllObjects];
        for(int i = 0; i < stateTacks.count; i++) {
            StateTackModel *m = [[StateTackModel alloc] init];
            [m setDict:stateTacks[i]];
            [_StateTacks addObject:m];
        }
        
    } @catch (NSException *exception) {
        
    }
}

@end
