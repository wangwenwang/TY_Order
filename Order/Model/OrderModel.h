//
//  OrderModel.h
//  YBDriver
//
//  Created by 凯东源 on 16/9/3.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailModel.h"
#import "StateTackModel.h"

/// 订单信息
@interface OrderModel : NSObject

// 1
/// 订单装运时间
@property(copy, nonatomic)NSString *TMS_DATE_LOAD;
/// 订单出库时间
@property(copy, nonatomic)NSString *TMS_DATE_ISSUE;
/// 订单装运编号
@property(copy, nonatomic)NSString *TMS_SHIPMENT_NO;
///
@property(copy, nonatomic)NSString *TMS_FLEET_NAME;
///
@property(copy, nonatomic)NSString *ORD_IDX;

// 2
@property(copy, nonatomic)NSString *IDX;
@property(copy, nonatomic)NSString *ORD_NO;
@property(copy, nonatomic)NSString *ORD_TO_NAME;
@property(copy, nonatomic)NSString *PARTY_TYPE;
@property(copy, nonatomic)NSString *ORD_TO_CNAME;

// 3
@property(copy, nonatomic)NSString *ORD_TO_ADDRESS;
@property(assign, nonatomic)float ORD_QTY;
@property(copy, nonatomic)NSString *ORD_WEIGHT;
@property(copy, nonatomic)NSString *ORD_VOLUME;
@property(assign, nonatomic)double ORD_ISSUE_QTY;

// 4
@property(copy, nonatomic)NSString *ORD_ISSUE_WEIGHT;
@property(copy, nonatomic)NSString *ORD_ISSUE_VOLUME;
@property(copy, nonatomic)NSString *ORD_WORKFLOW;
@property(copy, nonatomic)NSString *OMS_SPLIT_TYPE;
@property(copy, nonatomic)NSString *OMS_PARENT_NO;

// 5
@property(copy, nonatomic)NSString *ORD_STATE;
@property(copy, nonatomic)NSString *ORD_DATE_ADD;
@property(copy, nonatomic)NSString *ADD_CODE;
@property(copy, nonatomic)NSString *ORD_REQUEST_ISSUE;
@property(copy, nonatomic)NSString *ORD_FROM_NAME;

// 6
/// 起始点坐标
@property(copy, nonatomic)NSString *FROM_COORDINATE;
/// 到达点坐标
@property(copy, nonatomic)NSString *TO_COORDINATE;
@property(copy, nonatomic)NSString *ORD_REMARK_CLIENT;
/// 司机姓名
@property(copy, nonatomic)NSString *TMS_DRIVER_NAME;
/// 车牌号
@property(copy, nonatomic)NSString *TMS_PLATE_NUMBER;
/// 司机电话

// 7
@property(copy, nonatomic)NSString *TMS_DRIVER_TEL;
@property(copy, nonatomic)NSString *PAYMENT_TYPE;
@property(assign, nonatomic)double ORG_PRICE;
@property(assign, nonatomic)double ACT_PRICE;
@property(assign, nonatomic)double MJ_PRICE;

// 8
@property(copy, nonatomic)NSString *ORD_REMARK_CONSIGNEE;
@property(copy, nonatomic)NSString *MJ_REMARK;
@property(copy, nonatomic)NSString *DRIVER_PAY;
///
@property(strong, nonatomic)NSMutableArray *OrderDetails;
///
@property(strong, nonatomic)NSMutableArray *StateTacks;

- (void)setDict:(NSDictionary *)dict;

@end
