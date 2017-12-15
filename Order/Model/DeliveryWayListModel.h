//
//  DeliveryWayListModel.h
//  Order
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeliveryWayItemModel.h"

//{
//    "type": "1",
//    "msg": "获取消息成功",
//    "DeliveryWayItemModel": [
//                             {
//                                 "item_name": "送货",
//                                 "item_desc": "送货"
//                             },
//                             {
//                                 "item_name": "自提",
//                                 "item_desc": "自提"
//                             }
//                             ]
//}

@interface DeliveryWayListModel : NSObject

@property (nonatomic, strong) NSArray * deliveryWayItemModel;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
