//
//  Store_GetOupputListService.h
//  Order
//
//  Created by 凯东源 on 2017/8/18.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetOupputListModel.h"

@protocol Store_GetOupputListServiceDelegate <NSObject>

/// 出库列表 成功
@optional
- (void)successOfGetOupputList:(GetOupputListModel *)getOupputListM;

/// 出库列表 没有数据
@optional
- (void)successOfGetOupputList_NoData;

/// 出库列表 失败
@optional
- (void)failureOfGetOupputList:(NSString *)msg;

@end

@interface Store_GetOupputListService : NSObject

@property (weak, nonatomic)id <Store_GetOupputListServiceDelegate> delegate;

- (void)GetOupputList:(NSInteger)strPage andstrPageCount:(NSInteger)strPageCount;

@end
