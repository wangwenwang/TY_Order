//
//  GetDeliveryWayService.h
//  Order
//
//  Created by 凯东源 on 2017/12/11.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeliveryWayListModel.h"

/// 配送方式
@protocol GetDeliveryWayServiceDelegate <NSObject>

/// 获取配送方式成功
@optional
- (void)successOfGetDeliveryWay:(DeliveryWayListModel *)deliveryWayListM;

/// 获取配送方式失败
@optional
- (void)failureOfGetDeliveryWay:(NSString *)msg;

@end

@interface GetDeliveryWayService : NSObject

@property (weak, nonatomic) id<GetDeliveryWayServiceDelegate> delegate;


- (void)GetDeliveryWay;

@end
