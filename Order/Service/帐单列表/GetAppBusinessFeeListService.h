//
//  GetAppBusinessFeeListService.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetAppBusinessFeeListModel.h"

@protocol GetAppBusinessFeeListServiceDelegate <NSObject>

@optional
- (void)successOfGetAppBusinessFeeList:(GetAppBusinessFeeListModel *)GetAppBusinessFeeListM;

@optional
- (void)failureOfGetAppBusinessFeeList:(NSString *)msg;

@end

@interface GetAppBusinessFeeListService : NSObject

@property (weak, nonatomic) id <GetAppBusinessFeeListServiceDelegate> delegate;


- (void)GetAppBusinessFeeList:(NSString *)MONTH_DATE andBUSINESS_IDX:(NSString *)BUSINESS_IDX andPARTY_IDX:(NSString *)PARTY_IDX;

@end
