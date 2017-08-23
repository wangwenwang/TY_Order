//
//  Store_GetToAddressListService.h
//  Order
//
//  Created by 凯东源 on 2017/8/21.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetToAddressListModel.h"


@protocol Store_GetToAddressListServiceDelegate <NSObject>

/// 收货人地址 成功
@optional
- (void)successOfGetToAddressList:(GetToAddressListModel *)getToAddressListM;

/// 收货人地址 没有数据
@optional
- (void)successOfGetToAddressList_NoData;

/// 收货人地址 失败
@optional
- (void)failureOfGetToAddressList:(NSString *)msg;

@end

@interface Store_GetToAddressListService : NSObject

@property (weak, nonatomic)id <Store_GetToAddressListServiceDelegate> delegate;


- (void)GetToAddressList:(NSInteger)ADDRESS_IDX;

@end
