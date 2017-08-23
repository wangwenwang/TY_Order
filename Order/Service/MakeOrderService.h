//
//  MakeOrderService.h
//  Order
//
//  Created by 凯东源 on 16/10/12.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MakeOrderServiceDelegate <NSObject>

@optional
- (void)successOfMakeOrder:(NSMutableArray *)partys;

@optional
- (void)failureOfMakeOrder:(NSString *)msg;

@optional
- (void)successOfGetPartygetAddressInfo:(NSMutableArray *)address;

@optional
- (void)successOfGetPartygetAddressInfoNoData;

@optional
- (void)failureOfGetPartygetAddressInfo:(NSString *)msg;

@end

@interface MakeOrderService : NSObject

@property (weak, nonatomic) id <MakeOrderServiceDelegate> delegate;

/**
 * 获取客户列表
 *
 * @return 是否成功发送请求
 */
- (void)getCustomerData;


/**
 * 获取客户地址
 *
 * @return 发送请求是否成功
 */
- (void)getPartygetAddressInfo:(NSString *)partyIdx;

@end
