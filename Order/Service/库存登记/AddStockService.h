//
//  AddStockService.h
//  Order
//
//  Created by 凯东源 on 17/6/8.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddStockServiceDelegate <NSObject>

@optional
- (void)successOfAddStock:(NSString *)msg;

@optional
- (void)failureOfAddStock:(NSString *)msg;

@end

@interface AddStockService : NSObject

@property (weak, nonatomic) id <AddStockServiceDelegate> delegate;


- (void)AddStock:(NSString *)reuslt;

@end
