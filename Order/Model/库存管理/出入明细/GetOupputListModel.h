//
//  GetOupputListModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetOupputModel.h"


//{
//    "GetOupputModel": [
//                       {
//                           "IDX": "8",
//                           "ENT_IDX": "9008",
//                           "BUSINESS_IDX": "4",
//                           "OUTPUT_TYPE": "销售出库",
//                           "ADDRESS_IDX": "840",
//                           "ADDRESS_CODE": "ADG015",
//                           "ADDRESS_NAME": "深圳市国兰行",
//                           "ADDRESS_INFO": "广东省深圳市龙华区民治街道广东省深圳市宝安区民治街道南源新村12栋1楼",
//                           "OUTPUT_NO": "0000000009",
//                           "INPUT_NO": "",
//                           "PARTY_CODE": "21344",
//                           "PARTY_NAME": "21213",
//                           "PARTY_INFO": "13",
//                           "OUTPUT_QTY": "2.0000",
//                           "OUTPUT_SUM": "0.0000",
//                           "PRICE": "",
//                           "OUTPUT_DATE": "9008",
//                           "OUTPUT_WEIGHT": "",
//                           "OUTPUT_VOLUME": "2.0000",
//                           "PARTY_MARK": "",
//                           "ADUT_MARK": "",
//                           "OUTPUT_STATE": "CANCEL",
//                           "OUTPUT_WORKFLOW": "新建",
//                           "ADD_USER": "系统管理员",
//                           "ADD_DATE": "2017/8/17 10:46:02",
//                           "ADUT_USER": "",
//                           "ADUT_DATE": "",
//                           "EDIT_DATE": "2017/8/17 10:46:02",
//                           "OPER_USER": "系统管理员"
//                       },
//                       {
//                           "IDX": "6",
//                           "ENT_IDX": "9008",
//                           "BUSINESS_IDX": "4",
//                           "OUTPUT_TYPE": "销售出库",
//                           "ADDRESS_IDX": "10007",
//                           "ADDRESS_CODE": "ADG024",
//                           "ADDRESS_NAME": "永盛泰有限公司",
//                           "ADDRESS_INFO": "广东省深圳市龙岗区平湖街道广东省深圳市龙岗区平湖街道鹅公岭良安田",
//                           "OUTPUT_NO": "0000000008",
//                           "INPUT_NO": "",
//                           "PARTY_CODE": "ADG03HDX001",
//                           "PARTY_NAME": "韩迪熊",
//                           "PARTY_INFO": "广东省茂名市电白县水东镇广东省茂名市电白区水东站东阳南街2号",
//                           "OUTPUT_QTY": "3.0000",
//                           "OUTPUT_SUM": "0.0000",
//                           "PRICE": "",
//                           "OUTPUT_DATE": "9008",
//                           "OUTPUT_WEIGHT": "",
//                           "OUTPUT_VOLUME": "3.0000",
//                           "PARTY_MARK": "",
//                           "ADUT_MARK": "",
//                           "OUTPUT_STATE": "OPEN",
//                           "OUTPUT_WORKFLOW": "已出库",
//                           "ADD_USER": "系统管理员",
//                           "ADD_DATE": "2017/8/16 16:53:59",
//                           "ADUT_USER": "系统管理员",
//                           "ADUT_DATE": "2017/8/17 14:16:00",
//                           "EDIT_DATE": "2017/8/16 16:53:59",
//                           "OPER_USER": "系统管理员"
//                       }
//                       ]
//}


@interface GetOupputListModel : NSObject

@property (nonatomic, strong) NSArray * getOupputModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
