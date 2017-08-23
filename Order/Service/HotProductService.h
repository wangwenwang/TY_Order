//
//  HotProductService.h
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HotProductServiceDelegate <NSObject>

@optional
- (void)successOfHotProduct:(NSArray *)products;

@optional
- (void)failureOfHotProduct:(NSString *)msg;

@end

@interface HotProductService : NSObject

@property (weak, nonatomic) id <HotProductServiceDelegate> delegate;

/// 获取热销产品
- (void)getHotProductData;

@end
