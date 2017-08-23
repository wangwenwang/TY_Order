//
//  StockListModel.h
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockModel.h"



//{
//    "StockModel": [
//                   {
//                       "ADD_DATE": "2017-06-0509: 31: 33",
//                       "IDX": "4",
//                       "USER_NAME": "系统管理员",
//                       "ADDRESS_INFO": "广东省深圳市福田区华强北街道振兴路101号综合楼东一楼3号",
//                       "EDIT_DATE": "2017-06-0711: 33: 42",
//                       "PARTY_NAME": "锦绣洪业贸易有限公司",
//                       "CONTACT_PERSON": "史洪龙",
//                       "STOCK_DATE": "2000",
//                       "CONTACT_TEL": "13686888578",
//                       "BUSINESS_CODE": "ADG01",
//                       "PARTY_CODE": "ADG004",
//                       "SUBMIT_DATE": "2017-06-0709: 31: 33",
//                       "ENT_IDX": "9008",
//                       "BUSINESS_NAME": "深圳奥丁格"
//                   }
//                   ]
//}


@interface StockListModel : NSObject

@property (nonatomic, strong) NSArray * stockModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
