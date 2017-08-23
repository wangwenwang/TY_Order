//
//  AddAddressService.h
//  Order
//
//  Created by 凯东源 on 17/7/14.
//  Copyright © 2017年 凯东源. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddAddressServiceDelegate <NSObject>

@optional
- (void)successOfAddAddress:(NSString *)msg;

@optional
- (void)failureOfAddAddress:(NSString *)msg;

@end

@interface AddAddressService : NSObject

@property (weak, nonatomic) id <AddAddressServiceDelegate> delegate;


/**
 增加地址

 @param strUserId        用户ID
 @param PARTY_IDX        客户idx
 @param ADDRESS_CODE     地址代码
 @param ADDRESS_PROVINCE 省
 @param ADDRESS_CITY     市
 @param ADDRESS_AREA     区
 @param ADDRESS_RURAL    街道
 @param ADDRESS_ADDRESS  详细地址
 @param CONTACT_PERSON   人名
 @param CONTACT_TEL      电话
 @param ADDRESS_INFO     地址全拼
 */
- (void)AddAddress:(NSString *)strUserId andPARTY_IDX:(NSString *)PARTY_IDX andADDRESS_CODE:(NSString *)ADDRESS_CODE andADDRESS_PROVINCE:(NSString *)ADDRESS_PROVINCE andADDRESS_CITY:(NSString *)ADDRESS_CITY andADDRESS_AREA:(NSString *)ADDRESS_AREA andADDRESS_RURAL:(NSString *)ADDRESS_RURAL andADDRESS_ADDRESS:(NSString *)ADDRESS_ADDRESS andCONTACT_PERSON:(NSString *)CONTACT_PERSON andCONTACT_TEL:(NSString *)CONTACT_TEL andADDRESS_INFO:(NSString *)ADDRESS_INFO;

@end
