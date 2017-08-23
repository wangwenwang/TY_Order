//
//  GetAppStockListService.h
//  Order
//
//  Created by 凯东源 on 17/6/7.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppStockListModel.h"

@protocol GetAppStockListServiceDelegate <NSObject>

@optional
- (void)successOfGetAppStockList:(AppStockListModel *)appStockListM;

@optional
- (void)successOfGetAppStockListNoData;

@optional
- (void)failureOfGetAppStockList:(NSString *)msg;

@end

@interface GetAppStockListService : NSObject

@property (weak, nonatomic) id <GetAppStockListServiceDelegate> delegate;


- (void)GetAppStockList:(NSString *)StockIdx;

@end
