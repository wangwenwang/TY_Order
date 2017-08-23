//
//  PayTypeModel.h
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 支付类型
@interface PayTypeModel : NSObject

@property(copy, nonatomic)NSString *Key;

@property(copy, nonatomic)NSString *Text;

@property(assign, nonatomic)double SALE_PRICE;

/// 是否被选择
@property (assign, nonatomic) BOOL selected;

- (void)setDict:(NSDictionary *)dict;

@end
