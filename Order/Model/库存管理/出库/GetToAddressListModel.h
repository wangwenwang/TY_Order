//
//  GetToAddressListModel.h
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetToAddressModel.h"


//{
//    "GetToAddressModel": [
//                          {
//                              "IDX": "1",
//                              "ITEM_CODE": "AA",
//                              "PARTY_NAME": "水电费",
//                              "ADDRESS_INFO": "深圳市凯东源1号"
//                          },
//                          {
//                              "IDX": "2",
//                              "ITEM_CODE": "BB",
//                              "PARTY_NAME": "水电费1",
//                              "ADDRESS_INFO": "深圳市凯东源2号"
//                          },
//                          {
//                              "IDX": "3",
//                              "ITEM_CODE": "CC",
//                              "PARTY_NAME": "水电费2",
//                              "ADDRESS_INFO": "深圳市凯东源3号"
//                          }
//                          ]
//}


@interface GetToAddressListModel : NSObject

@property (nonatomic, strong) NSArray * getToAddressModel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
