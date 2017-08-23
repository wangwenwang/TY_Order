//
//  ProductTbModel.h
//  Order
//
//  Created by 凯东源 on 16/10/15.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 产品类型
@interface ProductTbModel : NSObject

@property(assign, nonatomic)long long IDX;

@property(copy, nonatomic)NSString *PRODUCT_TYPE;

@property(copy, nonatomic)NSString *PRODUCT_CLASS;

- (void)setDict:(NSDictionary *)dict;

@end
