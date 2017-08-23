//
//  AppStockListModel.h
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppStockModel.h"
#import "StockModel.h"

//{
//    "Stock": {
//        "IDX": "31",
//        "ENT_IDX": "9008",
//        "BUSINESS_IDX": "205",
//        "PARTY_IDX": "52868",
//        "STOCK_DATE": "2017-06",
//        "SUBMIT_DATE": "2017-06-08 16:06:05",
//        "USER_NAME": "凯东源测试帐号",
//        "ADD_DATE": "2017-06-08 16:06:18",
//        "EDIT_DATE": "2017-06-08 16:06:18",
//        "BUSINESS_CODE": "YIB18",
//        "BUSINESS_NAME": "珠海怡宝奶茶",
//        "PARTY_CODE": "YIB18-008",
//        "PARTY_NAME": "YIB18测试客户",
//        "STOCK_STATE": "CANCEL",
//        "STOCK_WORKFLOW": "新建"
//    },
//    "AppStock": [
//                 {
//                     "IDX": "60",
//                     "ENT_IDX": "9008",
//                     "STOCK_IDX": "31",
//                     "PRODUCT_IDX": "28238",
//                     "PRODUCT_NO": "YB.0111",
//                     "PRODUCT_NAME": "咖啡香浓,180ml,1×24",
//                     "PRODUCTION_DATE": "2017-06-08",
//                     "STOCK_QTY": "2",
//                     "STOCK_DATE": "2017-06",
//                     "USER_NAME": "凯东源测试帐号",
//                     "EXPIRATION_DAY": "12",
//                     "HUO_LING": "0.13",
//                     "THUO_LING": "0",
//                     "ADD_DATE": "2017-06-08 16:06:18",
//                     "EDIT_DATE": "2017-06-08 16:06:18",
//                     "DAOQI": "2018/6/7 0:00:00",
//                     "A_ZHUO_LING": "绿标",
//                     "A_ZTHUO_LING": "绿标"
//                 }
//                 ]
//}


@interface AppStockListModel : NSObject

@property (nonatomic, strong) NSArray * appStockModel;
@property (nonatomic, strong) StockModel * stockModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
