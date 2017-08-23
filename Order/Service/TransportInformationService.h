//
//  TransportInformationService.h
//  Order
//
//  Created by 凯东源 on 16/10/10.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderTmsModel.h"

@protocol TransportInformationServiceDelegate <NSObject>

@optional
- (void)successOfTransportInformation:(OrderTmsModel *)product;

@optional
- (void)failureOfTransportInformation:(NSString *)msg;

@end

@interface TransportInformationService : NSObject

@property (weak, nonatomic) id <TransportInformationServiceDelegate> delegate;

/**
 * 获取订单在途数据
 *
 * @param orderId 订单编号
 * @return 发送请求是否成功
 */
- (void)getTransInformationData:(NSString *)orderId;

@end
