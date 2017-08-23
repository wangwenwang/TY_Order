//
//  Store_GetOutProductListService.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreProductListModel.h"


@protocol Store_GetOutProductListServiceDelegate <NSObject>

/// 库存列表 成功
@optional
- (void)successOfGetOutProductList:(StoreProductListModel *)storeProductListM;

/// 库存列表 没有数据
@optional
- (void)successOfGetOutProductList_NoData;

/// 库存列表 失败
@optional
- (void)failureOfGetOutProductList:(NSString *)msg;

@end


@interface Store_GetOutProductListService : NSObject

@property (weak, nonatomic)id <Store_GetOutProductListServiceDelegate> delegate;


/**
 获取产品列表

 @param strPartyidx        客户id
 @param strOutputIdx       出库id
 @param strPartyAddressIdx 客户地址idx
 @param strPage            页码
 @param strPageCount       页面条数
 */
- (void)GetOutProductList:(NSInteger)strPartyidx andstrOutputIdx:(NSInteger)strOutputIdx andstrPartyAddressIdx:(NSInteger)strPartyAddressIdx andstrPage:(NSInteger)strPage andstrPageCount:(NSInteger)strPageCount;

@end
