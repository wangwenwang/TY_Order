//
//  UpdateAddressService.h
//  Order
//
//  Created by 凯东源 on 17/7/17.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UpdateAddressServiceDelegate <NSObject>

@optional
- (void)successOfUpdateAddress:(NSString *)msg;

@optional
- (void)failureOfUpdateAddress:(NSString *)msg;

@end

@interface UpdateAddressService : NSObject

@property (weak, nonatomic) id <UpdateAddressServiceDelegate> delegate;


/**
 修改地址

 @param strUserId        用户ID
 @param ADDRESS_IDX      地址idx
 @param ADDRESS_INFO     详细地址
 @param ADDRESS_PROVINCE 省
 @param ADDRESS_CITY     市
 @param ADDRESS_AREA     区
 @param ADDRESS_RURAL    街道
 @param ADDRESS_ADDRESS  详细地址
 @param CONTACT_PERSON   人名
 @param CONTACT_TEL      电话
 */
- (void)UpdateAddress:(NSString *)strUserId andADDRESS_IDX:(NSString *)ADDRESS_IDX andADDRESS_INFO:(NSString *)ADDRESS_INFO andADDRESS_PROVINCE:(NSString *)ADDRESS_PROVINCE andADDRESS_CITY:(NSString *)ADDRESS_CITY andADDRESS_AREA:(NSString *)ADDRESS_AREA andADDRESS_RURAL:(NSString *)ADDRESS_RURAL andADDRESS_ADDRESS:(NSString *)ADDRESS_ADDRESS andCONTACT_PERSON:(NSString *)CONTACT_PERSON andCONTACT_TEL:(NSString *)CONTACT_TEL;

@end
