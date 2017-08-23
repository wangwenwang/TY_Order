//
//  PromotionOrderModel.m
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import "PromotionOrderModel.h"
#import "OrderGiftModel.h"
#import "PromotionDetailModel.h"

@implementation PromotionOrderModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _IDX = 0;
        _ENT_IDX = 0;
        _ORG_IDX = 0;
        _BUSINESS_IDX = @"";
        _BUSINESS_TYPE = 0;
        
        _PAYMENT_TYPE = @"";
        _GROUP_NO = @"";
        _ORD_NO = @"";
        _ORD_NO_CLIENT = @"";
        _ORD_NO_CONSIGNEE = @"";
        
        _ORD_STATE = @"";
        _REQUEST_ISSUE = @"";
        _REQUEST_DELIVERY = @"";
        _CONSIGNEE_REMARK = @"";
        _ORG_PRICE = 0;
        
        _ACT_PRICE = 0;
        _MJ_PRICE = 0;
        _MJ_REMARK = @"";
        _TOTAL_QTY = 0;
        _TOTAL_WEIGHT = 0;
        
        _TOTAL_VOLUME = 0;
        _OPERATOR_IDX = 0;
        _ADD_DATE = @"";
        _EDIT_DATE = @"";
        _FROM_IDX = 0;
        
        _FROM_CODE = @"";
        _FROM_NAME = @"";
        _FROM_ADDRESS = @"";
        _FROM_PROPERTY = @"";
        _FROM_CNAME = @"";
        
        _FROM_CTEL = @"";
        _FROM_CSMS = @"";
        _FROM_COUNTRY = @"";
        _FROM_PROVINCE = @"";
        _FROM_CITY = @"";
        
        _FROM_REGION = @"";
        _FROM_ZIP = @"";
        _TO_IDX = 0;
        _TO_CODE = @"";
        _TO_NAME = @"";
        
        _TO_ADDRESS = @"";
        _TO_PROPERTY = @"";
        _TO_CNAME = @"";
        _TO_CTEL = @"";
        _TO_CSMS = @"";
        
        _TO_COUNTRY = @"";
        _TO_PROVINCE = @"";
        _TO_CITY = @"";
        _TO_REGION = @"";
        _TO_ZIP = @"";
        
        _PARTY_IDX = @"";
        _OrderDetails = [[NSMutableArray alloc] init];
        _HAVE_GIFT = @"";
        _GiftClasses = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict {
    
    @try {
        _IDX = dict[@"IDX"] ? [dict[@"IDX"] longLongValue] : _IDX;
        _ENT_IDX = dict[@"ENT_IDX"] ? [dict[@"ENT_IDX"] longLongValue] : _ENT_IDX;
        _ORG_IDX = dict[@"ORG_IDX"] ? [dict[@"ORG_IDX"] longLongValue] : _ORG_IDX;
        _BUSINESS_IDX = dict[@"BUSINESS_IDX"] ? dict[@"BUSINESS_IDX"] : _BUSINESS_IDX;
        _BUSINESS_TYPE = dict[@"BUSINESS_TYPE"] ? [dict[@"BUSINESS_TYPE"] longLongValue] : _BUSINESS_TYPE;
        
        _PAYMENT_TYPE = dict[@"PAYMENT_TYPE"] ? dict[@"PAYMENT_TYPE"] : _PAYMENT_TYPE;
        _GROUP_NO = dict[@"GROUP_NO"] ? dict[@"GROUP_NO"] : _GROUP_NO;
        _ORD_NO = dict[@"ORD_NO"] ? dict[@"ORD_NO"] : _ORD_NO;
        _ORD_NO_CLIENT = dict[@"ORD_NO_CLIENT"] ? dict[@"ORD_NO_CLIENT"] : _ORD_NO_CLIENT;
        _ORD_NO_CONSIGNEE = dict[@"ORD_NO_CONSIGNEE"] ? dict[@"ORD_NO_CONSIGNEE"] : _ORD_NO_CONSIGNEE;
        
        _ORD_STATE = dict[@"ORD_STATE"] ? dict[@"ORD_STATE"] : _ORD_STATE;
        _REQUEST_ISSUE = dict[@"REQUEST_ISSUE"] ? dict[@"REQUEST_ISSUE"] : _REQUEST_ISSUE;
        _REQUEST_DELIVERY = dict[@"REQUEST_DELIVERY"] ? dict[@"REQUEST_DELIVERY"] : _REQUEST_DELIVERY;
        _CONSIGNEE_REMARK = dict[@"CONSIGNEE_REMARK"] ? dict[@"CONSIGNEE_REMARK"] : _CONSIGNEE_REMARK;
        _ORG_PRICE = dict[@"ORG_PRICE"] ? [dict[@"ORG_PRICE"] doubleValue] : _ORG_PRICE;
        
        _ACT_PRICE = dict[@"ACT_PRICE"] ? [dict[@"ACT_PRICE"] doubleValue] : _ACT_PRICE;
        _MJ_PRICE = dict[@"MJ_PRICE"] ? [dict[@"MJ_PRICE"] doubleValue] : _MJ_PRICE;
        _MJ_REMARK = dict[@"MJ_REMARK"] ? dict[@"MJ_REMARK"] : _MJ_REMARK;
        _TOTAL_QTY = dict[@"TOTAL_QTY"] ? [dict[@"TOTAL_QTY"] longLongValue] : _TOTAL_QTY;
        _TOTAL_WEIGHT = dict[@"TOTAL_WEIGHT"] ? [dict[@"TOTAL_WEIGHT"] doubleValue] : _TOTAL_WEIGHT;
        
        _TOTAL_VOLUME = dict[@"TOTAL_VOLUME"] ? [dict[@"TOTAL_VOLUME"] doubleValue] : _TOTAL_VOLUME;
        _OPERATOR_IDX = dict[@"OPERATOR_IDX"] ? [dict[@"OPERATOR_IDX"] longLongValue] : _OPERATOR_IDX;
        _ADD_DATE = dict[@"ADD_DATE"] ? dict[@"ADD_DATE"] : _ADD_DATE;
        _EDIT_DATE = dict[@"EDIT_DATE"] ? dict[@"EDIT_DATE"] : _EDIT_DATE;
        _FROM_IDX = dict[@"FROM_IDX"] ? [dict[@"FROM_IDX"] longLongValue] : _FROM_IDX;
        
        _FROM_CODE = dict[@"FROM_CODE"] ? dict[@"FROM_CODE"] : _FROM_CODE;
        _FROM_NAME = dict[@"FROM_NAME"] ? dict[@"FROM_NAME"] : _FROM_NAME;
        _FROM_ADDRESS = dict[@"FROM_ADDRESS"] ? dict[@"FROM_ADDRESS"] : _FROM_ADDRESS;
        _FROM_PROPERTY = dict[@"FROM_PROPERTY"] ? dict[@"FROM_PROPERTY"] : _FROM_PROPERTY;
        _FROM_CNAME = dict[@"FROM_CNAME"] ? dict[@"FROM_CNAME"] : _FROM_CNAME;
        
        _FROM_CTEL = dict[@"FROM_CTEL"] ? dict[@"FROM_CTEL"] : _FROM_CTEL;
        _FROM_CSMS = dict[@"FROM_CSMS"] ? dict[@"FROM_CSMS"] : _FROM_CSMS;
        _FROM_COUNTRY = dict[@"FROM_COUNTRY"] ? dict[@"FROM_COUNTRY"] : _FROM_COUNTRY;
        _FROM_PROVINCE = dict[@"FROM_PROVINCE"] ? dict[@"FROM_PROVINCE"] : _FROM_PROVINCE;
        _FROM_CITY = dict[@"FROM_CITY"] ? dict[@"FROM_CITY"] : _FROM_CITY;
        
        _FROM_REGION = dict[@"FROM_REGION"] ? dict[@"FROM_REGION"] : _FROM_REGION;
        _FROM_ZIP = dict[@"FROM_ZIP"] ? dict[@"FROM_ZIP"] : _FROM_ZIP;
        _TO_IDX = dict[@"TO_IDX"] ? [dict[@"TO_IDX"] longLongValue] : _TO_IDX;
        _TO_CODE = dict[@"TO_CODE"] ? dict[@"TO_CODE"] : _TO_CODE;
        _TO_NAME = dict[@"TO_NAME"] ? dict[@"TO_NAME"] : _TO_NAME;
        
        _TO_ADDRESS = dict[@"TO_ADDRESS"] ? dict[@"TO_ADDRESS"] : _TO_ADDRESS;
        _TO_PROPERTY = dict[@"TO_PROPERTY"] ? dict[@"TO_PROPERTY"] : _TO_PROPERTY;
        _TO_CNAME = dict[@"TO_CNAME"] ? dict[@"TO_CNAME"] : _TO_CNAME;
        _TO_CTEL = dict[@"TO_CTEL"] ? dict[@"TO_CTEL"] : _TO_CTEL;
        _TO_CSMS = dict[@"TO_CSMS"] ? dict[@"TO_CSMS"] : _TO_CSMS;
        
        _TO_COUNTRY = dict[@"TO_COUNTRY"] ? dict[@"TO_COUNTRY"] : _TO_COUNTRY;
        _TO_PROVINCE = dict[@"TO_PROVINCE"] ? dict[@"TO_PROVINCE"] : _TO_PROVINCE;
        _TO_CITY = dict[@"TO_CITY"] ? dict[@"TO_CITY"] : _TO_CITY;
        _TO_REGION = dict[@"TO_REGION"] ? dict[@"TO_REGION"] : _TO_REGION;
        _TO_ZIP = dict[@"TO_ZIP"] ? dict[@"TO_ZIP"] : _TO_ZIP;
        
        _PARTY_IDX = dict[@"PARTY_IDX"] ? dict[@"PARTY_IDX"] : _PARTY_IDX;
        
        
        _OrderDetails = dict[@"OrderDetails"] ? dict[@"OrderDetails"] : _OrderDetails;
        NSMutableArray *promotionDetails = [[NSMutableArray alloc] init];
        for(int i = 0; i < _OrderDetails.count; i++) {
            PromotionDetailModel *m = [[PromotionDetailModel alloc] init];
            [m setDict:_OrderDetails[i]];
            [promotionDetails addObject:m];
        }
        _OrderDetails = promotionDetails;
        
        
        _HAVE_GIFT = dict[@"HAVE_GIFT"] ? dict[@"HAVE_GIFT"] : _HAVE_GIFT;
        _GiftClasses = dict[@"GiftClasses"] ? dict[@"GiftClasses"] : _GiftClasses;
        NSMutableArray *orderGifts = [[NSMutableArray alloc] init];
        for(int i = 0; i < _GiftClasses.count; i++) {
            OrderGiftModel *m = [[OrderGiftModel alloc] init];
            [m setDict:_GiftClasses[i]];
            [orderGifts addObject:m];
        }
        _GiftClasses = orderGifts;
        
        
    } @catch (NSException *exception) {
        
    }
}

@end
