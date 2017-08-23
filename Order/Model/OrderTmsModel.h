//
//  OrderTmsModel.h
//  Order
//
//  Created by 凯东源 on 16/10/10.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderTmsModel : NSObject

@property(copy, nonatomic)NSString *IDX;

@property(copy, nonatomic)NSString *ORD_TO_NAME;

@property(copy, nonatomic)NSString *ORD_TO_ADDRESS;

@property(assign, nonatomic)double ORD_QTY;

@property(copy, nonatomic)NSString *ORD_WEIGHT;

@property(copy, nonatomic)NSString *ORD_VOLUME;

@property(assign, nonatomic)double TMS_QTY;

@property(copy, nonatomic)NSString *TMS_WEIGHT;

@property(copy, nonatomic)NSString *TMS_VOLUME;

@property(strong, nonatomic)NSMutableArray *TmsList;

- (void)setDict:(NSDictionary *)dict;

@end
