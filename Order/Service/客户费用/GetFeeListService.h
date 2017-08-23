//
//  GetFeeListService.h
//  Order
//
//  Created by 凯东源 on 17/6/9.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeeListModel.h"

@protocol GetFeeListServiceDelegate <NSObject>

@optional
- (void)successOfGetFeeList:(FeeListModel *)feeListM;

@optional
- (void)failureOfGetFeeList:(NSString *)msg;

@end

@interface GetFeeListService : NSObject

@property (weak, nonatomic) id <GetFeeListServiceDelegate> delegate;


- (void)GetFeeList:(NSString *)BusinessIDX andPartyIdx:(NSString *)PartyIdx andFeeDate:(NSString *)FeeDate andstrPage:(NSUInteger)strPage andstrPageCount:(NSUInteger)strPageCount;

@end
