//
//  OrderCancelService.h
//  Order
//
//  Created by 凯东源 on 17/6/15.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrderCancelServiceDelegate <NSObject>

@optional
- (void)successOfOrderCancel:(NSString *)msg;

@optional
- (void)failureOfOrderCancel:(NSString *)msg;

@end

@interface OrderCancelService : NSObject

@property (weak, nonatomic) id <OrderCancelServiceDelegate> delegate;


- (void)OrderCancel:(NSString *)strOrderIdx andstrUserIdx:(NSString *)strUserIdx;

@end
