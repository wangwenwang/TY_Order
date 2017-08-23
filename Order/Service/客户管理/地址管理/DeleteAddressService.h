//
//  DeleteAddressService.h
//  Order
//
//  Created by 凯东源 on 17/7/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeleteAddressServiceDelegate <NSObject>

@optional
- (void)successOfDeleteAddress:(NSString *)msg;

@optional
- (void)failureOfDeleteAddress:(NSString *)msg;

@end

@interface DeleteAddressService : NSObject

@property (weak, nonatomic) id <DeleteAddressServiceDelegate> delegate;

- (void)DeleteAddress:(NSString *)ADDRESS_IDX;

@end
