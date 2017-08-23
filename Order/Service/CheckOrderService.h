//
//  CheckOrderService.h
//  Order
//
//  Created by 凯东源 on 16/9/28.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckOrderServiceDelegate <NSObject>

@optional
- (void)successOfCheckOrder:(NSMutableArray *)orders;

@optional
- (void)successOfCheckOrderNoData;

@optional
- (void)failureOfCheckOrder:(NSString *)msg;

@end

@interface CheckOrderService : NSObject

@property (weak, nonatomic) id <CheckOrderServiceDelegate> delegate;


/**
 * 获取订单数据
 *
 * 状态参数
 * OPEN
 * CLOSE
 * CANCEL
 */
- (void)getOrderData:(NSString *)status andPage:(int)page;

@end
