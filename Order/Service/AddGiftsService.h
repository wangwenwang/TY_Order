//
//  AddGiftsService.h
//  Order
//
//  Created by 凯东源 on 16/10/25.
//  Copyright © 2016年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddGiftsServiceDelegate <NSObject>

@optional
- (void)successOfAddGifts:(NSMutableArray *)promotionDetails;

@optional
- (void)failureOfAddGifts:(NSString *)msg;

@end

@interface AddGiftsService : NSObject

@property (weak, nonatomic)id <AddGiftsServiceDelegate> delegate;


/**
 * 获取赠品
 *
 * @return 发送请求是否成功
 */
- (void)getAddGiftsData:(NSString *)businessId andPartyIdx:(NSString *)partyIdx andPartyAddressIdx:(NSString *)partyAddressIdx andProductName:(NSString *)productName;

@end

