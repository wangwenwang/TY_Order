//
//  SetProductQtyService.h
//  Order
//
//  Created by 凯东源 on 2017/10/19.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 修改产品数量

@protocol SetProductQtyServiceDelegate <NSObject>

/// 修改成功
@optional
- (void)successOfSetProductQty:(NSString *)msg;

/// 修改失败
@optional
- (void)failureOfSetProductQty:(NSString *)msg;

@end

@interface SetProductQtyService : NSObject

@property (weak, nonatomic) id<SetProductQtyServiceDelegate> delegate;


- (void)SetProductQty:(NSString *)strOrderIdx andstrQty:(NSString *)strQty;

@end
