//
//  ProductChartModel.h
//  Order
//
//  Created by 凯东源 on 16/10/20.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 产品图表
@interface ProductChartModel : NSObject

@property (copy, nonatomic) NSString *PRODUCT_NAME;

@property (copy, nonatomic) NSString *PRODUCT_TYPE;

@property (copy, nonatomic) NSString *ACT_PRICE;

- (void)setDict:(NSDictionary *)dict;

@end
