//
//  GetAppBillFeeListModel.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppBillFeeModel.h"



//{
//    "AppBillFeeModel": [
//                        {
//                            "IDX": "2",
//                            "ENT_IDX": "9008",
//                            "BILL_NAME": "怡宝账单",
//                            "BILL_DATE": "2017-07",
//                            "BILL_STATE": "CLOSE",
//                            "BILL_WORKFLOW": "已审核",
//                            "USER_NAME": "系统管理员"
//                        },
//                        {
//                            "IDX": "5",
//                            "ENT_IDX": "9008",
//                            "BILL_NAME": "YIB18测试客户6月账单",
//                            "BILL_DATE": "2017-06",
//                            "BILL_STATE": "CLOSE",
//                            "BILL_WORKFLOW": "已审核",
//                            "USER_NAME": "系统管理员"
//                        },
//                        {
//                            "IDX": "4",
//                            "ENT_IDX": "9008",
//                            "BILL_NAME": "YIB18测试客户5月账单",
//                            "BILL_DATE": "2017-05",
//                            "BILL_STATE": "CLOSE",
//                            "BILL_WORKFLOW": "已审核",
//                            "USER_NAME": "系统管理员"
//                        }
//                        ]
//}


@interface GetAppBillFeeListModel : NSObject

@property (nonatomic, strong) NSArray * appBillFeeModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
