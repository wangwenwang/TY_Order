//
//  PolicyItemModel.h
//  Order
//
//  Created by 凯东源 on 16/10/14.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PolicyItemModel : NSObject

@property (strong, nonatomic) NSArray *Condition;

@property (strong, nonatomic) NSArray *Discount;

- (void)setDict:(NSDictionary *)dict;

@end
