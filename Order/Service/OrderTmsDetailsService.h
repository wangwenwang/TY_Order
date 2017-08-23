//
//  OrderTmsDetailsService.h
//  Order
//
//  Created by 凯东源 on 16/10/11.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"

@protocol OrderTmsDetailsServiceDelegate <NSObject>

@optional
- (void)successOfTmsDetails:(OrderModel *)order andPushVc:(NSString *)vcStr;

@optional
- (void)failureOfTmsDetails:(NSString *)msg;

@end

@interface OrderTmsDetailsService : NSObject

@property (weak, nonatomic) id <OrderTmsDetailsServiceDelegate> delegate;

/// 成功回调后push到哪个控制器
@property (copy, nonatomic)NSString *pushDirection;

/**
 * 网络获取订单物流详情数据
 * @return 发送请求是否成功
 * @param orderId 订单编号
 */
- (void)getOrderTmsDetailsData:(NSString *)orderId;

@end
