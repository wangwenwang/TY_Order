//
//  StoreProductListModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreProductModel.h"

//{
//    "type": "1",
//    "msg": "获取成功",
//    "StoreProductModel": [
//                     {
//                         "IDX": "33920",
//                         "BUSINESS_IDX": "122",
//                         "PRODUCT_NO": "YB.0111",
//                         "PRODUCT_NAME": "农夫山泉天然水/380ml×1×24",
//                         "PRODUCT_DESC": "380ml×24",
//                         "PRODUCT_BARCODE": "",
//                         "PRODUCT_TYPE": "农夫山泉",
//                         "PRODUCT_CLASS": "天然水",
//                         "PRODUCT_PRICE": "25",
//                         "PRODUCT_URL": "",
//                         "PRODUCT_VOLUME": "18252.00",
//                         "PRODUCT_WEIGHT": "9120.00",
//                         "PRODUCT_POLICY": [
//                                            {
//                                                "POLICY_NAME": "测试调价",
//                                                "POLICY_TYPE": "701_TJ",
//                                                "AMOUNT_START": "1.0000",
//                                                "AMOUNT_END": "100.0000",
//                                                "REQUEST_BATCH": "",
//                                                "SALE_PRICE": "24.0000"
//                                            }
//                                            ]
//                     },
//                     {
//                         "IDX": "33921",
//                         "BUSINESS_IDX": "122",
//                         "PRODUCT_NO": "YB.0112",
//                         "PRODUCT_NAME": "农夫山泉天然水/500ml×1×24",
//                         "PRODUCT_DESC": "500ml×24",
//                         "PRODUCT_BARCODE": "",
//                         "PRODUCT_TYPE": "农夫山泉",
//                         "PRODUCT_CLASS": "天然水",
//                         "PRODUCT_PRICE": "17.5",
//                         "PRODUCT_URL": "",
//                         "PRODUCT_VOLUME": "19803.00",
//                         "PRODUCT_WEIGHT": "12000.00",
//                         "PRODUCT_POLICY": []
//                     }
//                     ]
//}

@interface StoreProductListModel : NSObject

@property (nonatomic, strong) NSArray * storeProductModel;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
