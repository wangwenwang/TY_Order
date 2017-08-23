//
//  PromotionOrderModel.h
//  Order
//
//  Created by 凯东源 on 16/10/22.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionOrderModel : NSObject

@property(assign, nonatomic)long long IDX;

@property(assign, nonatomic)long long ENT_IDX;

@property(assign, nonatomic)long long ORG_IDX;

@property(copy, nonatomic)NSString *BUSINESS_IDX;

@property(assign, nonatomic)long long BUSINESS_TYPE;

@property(copy, nonatomic)NSString *PAYMENT_TYPE;

@property(copy, nonatomic)NSString *GROUP_NO;

@property(copy, nonatomic)NSString *ORD_NO;

@property(copy, nonatomic)NSString *ORD_NO_CLIENT;

@property(copy, nonatomic)NSString *ORD_NO_CONSIGNEE;

@property(copy, nonatomic)NSString *ORD_STATE;

@property(copy, nonatomic)NSString *REQUEST_ISSUE;

@property(copy, nonatomic)NSString *REQUEST_DELIVERY;

@property(copy, nonatomic)NSString *CONSIGNEE_REMARK;

@property(assign, nonatomic)double ORG_PRICE;

@property(assign, nonatomic)double ACT_PRICE;

@property(assign, nonatomic)double MJ_PRICE;

@property(copy, nonatomic)NSString *MJ_REMARK;

@property(assign, nonatomic)long long TOTAL_QTY;

@property(assign, nonatomic)double TOTAL_WEIGHT;

@property(assign, nonatomic)double TOTAL_VOLUME;

@property(assign, nonatomic)long long OPERATOR_IDX;

@property(copy, nonatomic)NSString *ADD_DATE;

@property(copy, nonatomic)NSString *EDIT_DATE;

@property(assign, nonatomic)long long FROM_IDX;

@property(copy, nonatomic)NSString *FROM_CODE;

@property(copy, nonatomic)NSString *FROM_NAME;

@property(copy, nonatomic)NSString *FROM_ADDRESS;

@property(copy, nonatomic)NSString *FROM_PROPERTY;

@property(copy, nonatomic)NSString *FROM_CNAME;

@property(copy, nonatomic)NSString *FROM_CTEL;

@property(copy, nonatomic)NSString *FROM_CSMS;

@property(copy, nonatomic)NSString *FROM_COUNTRY;

@property(copy, nonatomic)NSString *FROM_PROVINCE;

@property(copy, nonatomic)NSString *FROM_CITY;

@property(copy, nonatomic)NSString *FROM_REGION;

@property(copy, nonatomic)NSString *FROM_ZIP;

@property(assign, nonatomic)long long TO_IDX;

@property(copy, nonatomic)NSString *TO_CODE;

@property(copy, nonatomic)NSString *TO_NAME;

@property(copy, nonatomic)NSString *TO_ADDRESS;

@property(copy, nonatomic)NSString *TO_PROPERTY;

@property(copy, nonatomic)NSString *TO_CNAME;

@property(copy, nonatomic)NSString *TO_CTEL;

@property(copy, nonatomic)NSString *TO_CSMS;

@property(copy, nonatomic)NSString *TO_COUNTRY;

@property(copy, nonatomic)NSString *TO_PROVINCE;

@property(copy, nonatomic)NSString *TO_CITY;

@property(copy, nonatomic)NSString *TO_REGION;

@property(copy, nonatomic)NSString *TO_ZIP;

@property(copy, nonatomic)NSString *PARTY_IDX;

@property (strong, nonatomic)NSMutableArray *OrderDetails;

//赠品用
@property(copy, nonatomic)NSString *HAVE_GIFT;

@property (strong, nonatomic)NSMutableArray *GiftClasses;

- (void)setDict:(NSDictionary *)dict;

@end
