//
//  CustomerChartModel.h
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 客户图表
@interface CustomerChartModel : NSObject

@property (copy, nonatomic) NSString *TO_CITY;

@property (assign, nonatomic) double ORD_QTY;

@property (assign, nonatomic) double ORG_PRICE;

- (void)setDict:(NSDictionary *)dict;

@end
