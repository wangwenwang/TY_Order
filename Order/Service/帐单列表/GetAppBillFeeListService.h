//
//  GetAppBillFeeListService.h
//  Order
//
//  Created by 凯东源 on 17/7/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetAppBillFeeListModel.h"

@protocol GetAppBillFeeListServiceDelegate <NSObject>

@optional
- (void)successOfGetAppBillFeeList:(GetAppBillFeeListModel *)GetAppBillFeeListM;

@optional
- (void)failureOfGetAppBillFeeList:(NSString *)msg;

@end

@interface GetAppBillFeeListService : NSObject

@property (weak, nonatomic) id <GetAppBillFeeListServiceDelegate> delegate;


- (void)GetAppBillFeeList:(NSUInteger)strPage andstrPageCount:(NSUInteger)strPageCount;

@end
