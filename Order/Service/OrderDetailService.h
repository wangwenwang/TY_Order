//
//  OrderDetailService.h
//  Order
//
//  Created by 凯东源 on 16/10/8.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@protocol OrderDetailServiceDelegate <NSObject>

@optional
- (void)successOfOrderDetail:(OrderModel *)order;

@optional
- (void)failureOfOrderDetail:(NSString *)msg;

@end

@interface OrderDetailService : NSObject

@property (weak, nonatomic) id <OrderDetailServiceDelegate> delegate;

/**
 * 网络请求订单详情数据
 *
 * @param orderId 订单编号
 */
- (void)getOrderDetailsData:(NSString *)orderID;

@end
