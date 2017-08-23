//
//  ProductPolicyModel.h
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 产品策略实体类
@interface ProductPolicyModel : NSObject

@property(copy, nonatomic)NSString *POLICY_NAME;

@property(copy, nonatomic)NSString *POLICY_TYPE;

@property(copy, nonatomic)NSString *AMOUNT_START;

@property(copy, nonatomic)NSString *AMOUNT_END;

@property(copy, nonatomic)NSString *REQUEST_BATCH;

@property(copy, nonatomic)NSString *SALE_PRICE;

@property(strong, nonatomic)NSMutableArray *PolicyItems;

- (void)setDict:(NSDictionary *)dict;

@end
