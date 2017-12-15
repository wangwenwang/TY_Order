//
//  DeliveryWayItemModel.h
//  Order
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliveryWayItemModel : NSObject

@property (nonatomic, strong) NSString * itemDesc;
@property (nonatomic, strong) NSString * itemName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
