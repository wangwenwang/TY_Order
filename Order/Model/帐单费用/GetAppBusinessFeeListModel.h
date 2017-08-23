//
//  GetAppBusinessFeeListModel.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppBusinessFeeListModel.h"
#import "AppBusinessFeeModel.h"


//{
//    "AppBusinessFeeModel": {
//        "PARTY_CODE": "YIB18-008",
//        "PARTY_NAME": "YIB18测试客户",
//        "BUSINESS_CODE": "YIB18",
//        "BUSINESS_NAME": "珠海怡宝奶茶",
//        "LastMonth": "-18482",
//        "ThisMonthPostive": "110",
//        "ThisMonthMinus": "-70",
//        "ThisMonth": "-18442"
//    },
//    "AppBusinessFeeListModel": [
//                                {
//                                    "FEE_NAME": "销售收入（4月份怡宝饮料58463件）",
//                                    "FEE_AMOUNT": "13720.0000",
//                                    "FEE_DATE": "2017/6/12 0:00:00"
//                                },
//                                {
//                                    "FEE_NAME": "预收冲应收",
//                                    "FEE_AMOUNT": "-27552.0000",
//                                    "FEE_DATE": "2017/6/18 0:00:00"
//                                }
//                                ]
//}


@interface GetAppBusinessFeeListModel : NSObject

@property (nonatomic, strong) NSArray * appBusinessFeeListModel;
@property (nonatomic, strong) AppBusinessFeeModel * appBusinessFeeModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
