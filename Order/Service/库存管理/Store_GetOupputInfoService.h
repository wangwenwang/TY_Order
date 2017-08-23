//
//  Store_GetOupputInfoService.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetOupputDetailModel.h"

@protocol Store_GetOupputInfoServiceDelegate <NSObject>

/// 出库列表 成功
@optional
- (void)successOfGetOupputInfo:(GetOupputDetailModel *)getOupputDetailM;

/// 出库列表 失败
@optional
- (void)failureOfGetOupputInfo:(NSString *)msg;

@end

@interface Store_GetOupputInfoService : NSObject

@property (weak, nonatomic)id <Store_GetOupputInfoServiceDelegate> delegate;


- (void)GetOupputInfo:(NSInteger)OutputIdx;

@end
