//
//  GetOupputDetailModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/22.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetOupputInfoModel.h"
#import "GetOupputItemModel.h"

//{
//    "GetOupputInfoModel": {
//        "IDX": "13",
//        "ENT_IDX": "9008",
//        "BUSINESS_IDX": "销售出库",
//        "ADDRESS_IDX": "2268",
//        "ADDRESS_CODE": "YBHN0-0630",
//        "ADDRESS_NAME": "深圳市福田区老兴发日用品商店",
//        "ADDRESS_INFO": "广东省深圳市福田区沙头街道福田区新洲二街罗湖工商所员工宿舍楼1北栋107",
//        "OUTPUT_NO": "",
//        "INPUT_NO": "",
//        "PARTY_CODE": "YBHN0-0450-03",
//        "PARTY_NAME": "深圳市友润加油站有限公司龙岗",
//        "PARTY_INFO": "广东省深圳市龙岗区平湖街道深圳市龙岗区平湖路大水收费站",
//        "OUTPUT_QTY": "7.0000",
//        "OUTPUT_SUM": "0.0000",
//        "PRICE": "326.0000",
//        "OUTPUT_DATE": "",
//        "OUTPUT_WEIGHT": "0.06",
//        "OUTPUT_VOLUME": "0.18",
//        "PARTY_MARK": "",
//        "ADUT_MARK": "",
//        "OUTPUT_STATE": "OPEN",
//        "OUTPUT_WORKFLOW": "新建",
//        "ADD_USER": "系统管理员",
//        "ADD_DATE": "2017-08-18 17:24:39",
//        "ADUT_USER": "",
//        "ADUT_DATE": "",
//        "EDIT_DATE": "2017-08-18 17:24:39",
//        "OPER_USER": "系统管理员"
//    },
//    "GetOupputItemModel": [
//                           {
//                               "IDX": "40",
//                               "ENT_IDX": "9008",
//                               "OUTPUT_IDX": "13",
//                               "PRODUCT_TYPE": "NR",
//                               "PRODUCT_IDX": "419",
//                               "PRODUCT_NO": "YB.0109",
//                               "PRODUCT_NAME": "奶茶巧克力,500ml,1×15",
//                               "PRODUCT_DESC": "500ml×15",
//                               "SUM": "",
//                               "PRODUCT_WEIGHT": "0.0090",
//                               "PRODUCT_VOLUME": "0.0373",
//                               "LINE_NO": "3",
//                               "OUTPUT_QTY": "4.0000",
//                               "OUTPUT_UOM": "4",
//                               "OUTPUT_WEIGHT": "0.04",
//                               "OUTPUT_VOLUME": "0.15",
//                               "ORG_PRICE": "40.0000",
//                               "ACT_PRICE": "0.1",
//                               "SALE_REMARK": "",
//                               "MJ_PRICE": "",
//                               "MJ_REMARK": "",
//                               "PRODUCTION_DATE": "",
//                               "BATCH_NUMBER": "",
//                               "PRODUCT_STATE": "NR",
//                               "ADD_DATE": "2017-08-21 10:10:32",
//                               "EDIT_DATE": "2017-08-21 10:10:32",
//                               "OPER_USER": "系统管理员"
//                           },
//                           {
//                               "IDX": "39",
//                               "ENT_IDX": "9008",
//                               "OUTPUT_IDX": "13",
//                               "PRODUCT_TYPE": "NR",
//                               "PRODUCT_IDX": "416",
//                               "PRODUCT_NO": "YB.0112",
//                               "PRODUCT_NAME": "咖啡倍醇,280ml,1×24",
//                               "PRODUCT_DESC": "280ml×24",
//                               "SUM": "",
//                               "PRODUCT_WEIGHT": "0.0083",
//                               "PRODUCT_VOLUME": "0.0119",
//                               "LINE_NO": "2",
//                               "OUTPUT_QTY": "2.0000",
//                               "OUTPUT_UOM": "3",
//                               "OUTPUT_WEIGHT": "0.02",
//                               "OUTPUT_VOLUME": "0.02",
//                               "ORG_PRICE": "56.0000",
//                               "ACT_PRICE": "0.1",
//                               "SALE_REMARK": "",
//                               "MJ_PRICE": "",
//                               "MJ_REMARK": "",
//                               "PRODUCTION_DATE": "",
//                               "BATCH_NUMBER": "",
//                               "PRODUCT_STATE": "NR",
//                               "ADD_DATE": "2017-08-18 17:36:22",
//                               "EDIT_DATE": "2017-08-18 17:36:22",
//                               "OPER_USER": "系统管理员"
//                           }
//                           ]
//}


@interface GetOupputDetailModel : NSObject

@property (nonatomic, strong) GetOupputInfoModel * getOupputInfoModel;
@property (nonatomic, strong) NSArray * getOupputItemModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
