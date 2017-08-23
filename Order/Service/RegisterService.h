//
//  RegisterService.h
//  CMClient
//
//  Created by 凯东源 on 17/1/14.
//  Copyright © 2017年 城马联盟. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 用户注册协议
@protocol RegisterServiceDelegate <NSObject>

@optional
- (void)successOfRegister;

@optional
- (void)failureOfRegister:(NSString *)msg;

@end


/// RegisterService类
@interface RegisterService : NSObject

@property (weak, nonatomic)id <RegisterServiceDelegate> delegate;


/**
 注册

 @param strUserName      用户名
 @param strPwd           密码
 @param strUserCode      手机号码
 @param PARTY_NAME       客户名称
 @param PARTY_CITY       客户城市
 @param CONTACT_PERSON   联系人
 @param CONTACT_TEL      联系人电话
 @param PARTY_REMARK     备注
 @param ADDRESS_PROVINCE 省
 @param ADDRESS_CITY     市
 @param ADDRESS_AREA     区/县
 @param ADDRESS_RURAL    街道/镇
 @param ADDRESS_ADDRESS  详细地址
 @param ADDRESS_ADDRESS  地址全称
 */
- (void)registerX:(NSString *)strUserName andstrPwd:(NSString *)strPwd andstrUserCode:(NSString *)strUserCode andPARTY_NAME:(NSString *)PARTY_NAME andPARTY_CITY:(NSString *)PARTY_CITY andCONTACT_PERSON:(NSString *)CONTACT_PERSON andCONTACT_TEL:(NSString *)CONTACT_TEL andPARTY_REMARK:(NSString *)PARTY_REMARK andADDRESS_PROVINCE:(NSString *)ADDRESS_PROVINCE and:(NSString *)ADDRESS_CITY andADDRESS_AREA:(NSString *)ADDRESS_AREA andADDRESS_RURAL:(NSString *)ADDRESS_RURAL andADDRESS_ADDRESS:(NSString *)ADDRESS_ADDRESS andADDRESS_INFO:(NSString *)ADDRESS_INFO;

@end
