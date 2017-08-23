//
//  CancelStockService.h
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CancelStockServiceDelegate <NSObject>

@optional
- (void)successOfCancelStock:(NSString *)msg;

@optional
- (void)failureOfCancelStock:(NSString *)msg;

@end

@interface CancelStockService : NSObject

@property (weak, nonatomic) id <CancelStockServiceDelegate> delegate;


- (void)CancelStock:(NSString *)StockIdx;

@end
