//
//  GetStockListService.h
//  Order
//
//  Created by 凯东源 on 17/6/6.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockListModel.h"

@protocol GetStockListServiceDelegate <NSObject>

@optional
- (void)successOfGetStockList:(StockListModel *)stockListM;

@optional
- (void)successOfGetStockListNoData;

@optional
- (void)failureOfGetStockList:(NSString *)msg;

@end

@interface GetStockListService : NSObject

@property (weak, nonatomic) id <GetStockListServiceDelegate> delegate;

/// 获取客户库存登记表
- (void)GetStockList:(NSString *)UserName andstrPage:(NSUInteger)strPage andstrPageCount:(NSUInteger)strPageCount and:(NSString *)strUserId andstrBusinessId:(NSString *)strBusinessId;

@end
