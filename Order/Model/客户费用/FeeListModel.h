//
//  FeeListModel.h
//  Order
//
//  Created by 凯东源 on 17/6/12.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeeModel.h"


//{
//    "FeeModel": [
//                 {
//                     "ENT_IDX": "9008",
//                     "IDX": "1",
//                     "USER_NAME": "系统管理员",
//                     "ADD_DATE": "",
//                     "FEE_NAME": "23",
//                     "EDIT_DATE": "",
//                     "PARTY_NAME": "李可达",
//                     "FEE_DATE": "2017/7/40: 00: 00",
//                     "BUSINESS_CODE": "YIB18",
//                     "PARTY_CODE": "YIB18-003",
//                     "FEE_DESC": "23",
//                     "FEE_AMOUNT": "66.0000",
//                     "BUSINESS_NAME": "珠海怡宝奶茶"
//                 }
//                 ]
//}



@interface FeeListModel : NSObject

@property (nonatomic, strong) NSMutableArray * feeModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
